<#
.SYNOPSIS
  The mod's own test suite. Runs without RimWorld, in under twenty seconds.

.DESCRIPTION
  This repository holds one mod and no longer sits inside the monorepo, so the five checkers
  that live under its scripts/ are not next to it any more. They are still the deeper
  instruments, and the field walk below is a compact version of Check-XmlFields.ps1 brought in
  here rather than depended on: a detached repository has to be able to test itself.

  This mod ships no assembly, so there is no mod C# to instantiate. What takes its place is the
  vanilla side: the suite loads Assembly-CSharp by reflection and asks the game's own classes
  what this mod is allowed to assume.

  Four groups, twenty-four tests:

    About and images   the identity that must never change, the two pictures, the texture, and
                       the cost the showcase text claims against the cost the def charges
    The defs           parses, prefixes, every element a real 1.6 field, every class and every
                       def reference resolving
    The rules          the things this mod rests on, each tested against the game rather than
                       against its own prose
    Translations       every [MustTranslate] string covered, every French key pointing at
                       something real, in a folder spelled the way the class is

  The third group is the point of having a suite at all. Each of those tests encodes a sentence
  the README states as fact, and computes it from the game instead of trusting it:

    - "it works because a crystal ball is a Building" is checked by resolving the def's
      thingClass through the vanilla parent chain and comparing it with the return type of
      JobDriver_SitFacingBuilding.Building - the driver's own accessor, which is what would
      raise the InvalidCastException on anything else.
    - "an eleventh recreation type" is checked by counting the vanilla JoyKindDefs, so the day
      a RimWorld release adds one, this says eleventh is taken.
    - "only four of the ten come from a building" is computed from Core's JoyGiverDefs that
      name a building. Not from the <building><joyKind> blocks, which give five: the musical
      instrument base sits in Core while the JoyGiverDef that makes anyone play it ships with
      Royalty. Items are filtered out the same way - chocolate is a thingDef on a JoyGiverDef
      too, and it is not furniture.
    - "no chair needed" is checked as the field the vanilla giver actually reads.
    - the glow's zero alpha is checked against every CompProperties_Glower in the game data.

  The suite writes with Write-Output and never Write-Host: the output has to survive being piped
  into a file or a variable, which Write-Host does not.

  Exit code 0 when everything passes, 1 otherwise.

  EVERY TEST HERE HAS BEEN SEEN TO FAIL. A suite that goes green on its first run has proved
  nothing, so twenty-three faults were introduced one at a time into a copy of the mod in a
  scratch directory - never into the real files - and each had to be named by the right test:

    packageId changed                             -> the identity test, alone
    Preview.png swapped for the source art        -> the 896 x 504 test, size and weight
    ModIcon.png swapped for Preview.png           -> the 128 x 128 test
    CrystalBall miscased Crystalball in texPath   -> the texture test, naming the file it found
    "40 jade" turned into "30 jade" in the README -> the cost-drift test, naming README.md
    the def file made malformed                   -> the parse test, and twelve others saying
                                                     which def they no longer find
    the JoyKindDef's defName stripped of its CB_  -> prefix, references, eleventh type,
                                                     needsThing and both translation tests: six
    the JoyGiverDef declared twice                -> the collision test
    socialPropernessMatters misspelt              -> the field walk, naming element and class
    CompProperties_Glower misspelt                -> the class test, the field walk under it,
                                                     and the alpha test
    jobDef pointed at a job that does not exist   -> the reference test and the agreement test
    the JobDef deleted, its giver kept, the two   -> the reference test, naming "no JobDef named
    sharing one defName                              CB_GazeIntoCrystalBall". It stayed green
                                                     while the reference check compared names
                                                     only, and the mutation above hid that by
                                                     choosing a name nothing carried.
    ParentName changed to a template nobody has   -> the parent test and the Building test
    requireChair removed                          -> the chair test
    the JoyKindDef renamed Meditative             -> the eleventh-type test, naming the
                                                     collision, and five more
    needsThing set to false                       -> the building-borne test
    minifiedDef removed                           -> the categories test
    glowColor given a 255 alpha                   -> the alpha test
    the French label deleted                      -> the MustTranslate test
    a French key pointed at a field that is gone  -> the handle test and the MustTranslate one
    DefInjected/ThingDef renamed thingdef         -> the folder-spelling test
    a French paragraph break dropped              -> the last test

  The two tests that read nothing but the game's data cannot be reached that way, so they were
  run against a doctored copy of Data in the scratch directory - eleven JoyKindDefs, five of them
  served by a building - and reported both, by number and by name.

  The first of those runs rewrote a test rather than confirming it. The texture check was a
  Test-Path, and Test-Path finds Crystalball.png when the def asks for CrystalBall: the fault it
  was written for is invisible on Windows and fatal on Linux. It now walks the path segment by
  segment and compares each name case-sensitively.

.EXAMPLE
  powershell -NoProfile -File _tools/Run-Tests.ps1

.EXAMPLE
  # From Git Bash, where the machine's execution policy refuses a script file:
  powershell -NoProfile -ExecutionPolicy Bypass -File _tools/Run-Tests.ps1
#>

param(
    [string]$ModRoot  = (Split-Path -Parent $PSScriptRoot),
    [string]$GameData = 'C:\Program Files (x86)\Steam\steamapps\common\RimWorld\Data',
    [string]$Managed  = 'C:\Program Files (x86)\Steam\steamapps\common\RimWorld\RimWorldWin64_Data\Managed'
)

$ErrorActionPreference = 'Stop'

# ---------------------------------------------------------------------------------------------
# Harness
# ---------------------------------------------------------------------------------------------

$script:ran = 0
$script:failed = 0

# A test body writes its problems to the pipeline and stays silent when it has none. No
# assertion vocabulary: one test that lists every offending element beats ten that stop at the
# first.
function It([string]$name, [scriptblock]$body) {
    $script:ran++
    $problems = @()
    try   { $problems = @(& $body | Where-Object { $_ }) }
    catch { $problems = @("threw: $($_.Exception.Message)") }

    if ($problems.Count -eq 0) {
        Write-Output "  ok    $name"
    } else {
        $script:failed++
        Write-Output "  FAIL  $name"
        foreach ($p in $problems) { Write-Output "          $p" }
    }
}

function Section([string]$name) { Write-Output ''; Write-Output $name }

# ---------------------------------------------------------------------------------------------
# What the mod ships
# ---------------------------------------------------------------------------------------------

$modDir   = Join-Path $ModRoot 'Mod'
$defFiles = @(Get-ChildItem (Join-Path $modDir 'Defs') -Recurse -Filter *.xml)

# Parsed once: a malformed file is reported by the first test and would otherwise throw in every
# other one. $null for a file that does not parse.
$docs = @{}
foreach ($f in $defFiles) {
    try { $x = New-Object System.Xml.XmlDocument; $x.Load($f.FullName); $docs[$f.FullName] = $x }
    catch { $docs[$f.FullName] = $null }
}

# Element names are read with .LocalName, never .Name: PowerShell's XML adapter shadows .Name
# with a "Name" attribute where one exists, and the abstract templates carry exactly that.
function Get-DefNodes {
    foreach ($f in $defFiles) {
        $x = $docs[$f.FullName]
        if ($null -eq $x -or $null -eq $x.DocumentElement) { continue }
        foreach ($n in $x.DocumentElement.ChildNodes) { if ($n.NodeType -eq 'Element') { $n } }
    }
}

$defNodes = @(Get-DefNodes)

# defName -> the kinds of def that carry it. A list, not a single value: the job and the giver
# deliberately share CB_GazeIntoCrystalBall, the way vanilla's chess pair does.
$modDefs = @{}
foreach ($n in $defNodes) {
    $dn = [string]$n.defName
    if ([string]::IsNullOrWhiteSpace($dn)) { continue }
    if (-not $modDefs.ContainsKey($dn)) { $modDefs[$dn] = @() }
    $modDefs[$dn] += $n.LocalName
}

function Get-ModDef([string]$type, [string]$defName) {
    foreach ($n in $defNodes) {
        if ($n.LocalName -eq $type -and [string]$n.defName -eq $defName) { return $n }
    }
    return $null
}

$ballNode  = Get-ModDef 'ThingDef'    'CB_CrystalBall'
$jobNode   = Get-ModDef 'JobDef'      'CB_GazeIntoCrystalBall'
$giverNode = Get-ModDef 'JoyGiverDef' 'CB_GazeIntoCrystalBall'

# The recreation type is taken by kind rather than by name, so that a test about what it collides
# with still has it in hand when the collision is the name itself.
$kindNodes = @($defNodes | Where-Object { $_.LocalName -eq 'JoyKindDef' })
$kindNode  = $(if ($kindNodes.Count -gt 0) { $kindNodes[0] })

# ---------------------------------------------------------------------------------------------
# The game's classes, by reflection
# ---------------------------------------------------------------------------------------------
#
# Assembly-CSharp is resolvable but not fully loadable outside RimWorld - it references Unity
# assemblies that are not all there - so GetTypes() always throws. The exception still carries
# every type it did resolve, which is all of them but a handful, and none of the handful is
# touched here. The guard against asking twice for the same name is the one from the monorepo's
# Check-XmlFields.ps1: an unresolvable name asked twice recurses to a stack overflow instead of
# erroring.

$script:probed = @{}
$script:asmResolver = [System.ResolveEventHandler]{
    param($sender, $e)
    if ($null -eq $script:probed) { return $null }
    $short = $e.Name.Split(',')[0]
    if ($script:probed.ContainsKey($short)) { return $null }
    $script:probed[$short] = $true
    $p = Join-Path $Managed "$short.dll"
    if (Test-Path $p) { return [System.Reflection.Assembly]::LoadFrom($p) }
    return $null
}
[System.AppDomain]::CurrentDomain.add_AssemblyResolve($script:asmResolver)

function Get-AssemblyTypes([string]$path) {
    $a = [System.Reflection.Assembly]::LoadFrom($path)
    try     { return $a.GetTypes() }
    catch [System.Reflection.ReflectionTypeLoadException] { return $_.Exception.Types | Where-Object { $_ } }
    catch   { return $_.Exception.InnerException.Types | Where-Object { $_ } }
}

$byName  = @{}
$asmPath = Join-Path $Managed 'Assembly-CSharp.dll'
if (Test-Path $asmPath) {
    foreach ($t in @(Get-AssemblyTypes $asmPath)) {
        if (-not $byName.ContainsKey($t.Name)) { $byName[$t.Name] = $t }
        if ($t.FullName -and -not $byName.ContainsKey($t.FullName)) { $byName[$t.FullName] = $t }
    }
}
$defType = $byName['Verse.Def']

$BF = [System.Reflection.BindingFlags]::Public    -bor `
      [System.Reflection.BindingFlags]::NonPublic -bor `
      [System.Reflection.BindingFlags]::Instance  -bor `
      [System.Reflection.BindingFlags]::DeclaredOnly

# GetFields on a derived type does not return private fields of its base types, and RimWorld has
# plenty. Walk the chain by hand, and index a renamed field under its [LoadAlias] too: the loader
# looks the aliases up, so such an element is honoured, not dropped.
$fieldCache = @{}
function Get-FieldsRecursive([Type]$t) {
    if ($fieldCache.ContainsKey($t)) { return $fieldCache[$t] }
    $d = @{}
    $cur = $t
    while ($cur -and $cur.FullName -ne 'System.Object') {
        foreach ($f in $cur.GetFields($BF)) {
            if (-not $d.ContainsKey($f.Name)) { $d[$f.Name] = $f }
            foreach ($a in $f.CustomAttributes) {
                if ($a.AttributeType.Name -ne 'LoadAliasAttribute') { continue }
                foreach ($arg in $a.ConstructorArguments) {
                    $alias = [string]$arg.Value
                    if ($alias -and -not $d.ContainsKey($alias)) { $d[$alias] = $f }
                }
            }
        }
        $cur = $cur.BaseType
    }
    $fieldCache[$t] = $d
    return $d
}

# A type that implements LoadDataFromXmlCustom is invisible to field reflection: RimWorld hands
# it the raw node and it reads whatever it likes. StatModifier and ThingDefCountClass, the two
# this mod writes, are among them. What can still be asserted under one is that every child is a
# leaf: an <li> carrying element children is the dictionary form, which no RimWorld version
# accepts and which aborts the WHOLE def rather than the one field.
$customLoaderCache = @{}
function Test-CustomLoader([Type]$t) {
    if (-not $t) { return $false }
    if ($customLoaderCache.ContainsKey($t)) { return $customLoaderCache[$t] }
    $r = $null -ne $t.GetMethod('LoadDataFromXmlCustom', $BF -bxor [System.Reflection.BindingFlags]::DeclaredOnly)
    $customLoaderCache[$t] = $r
    return $r
}

# Two wrappers stand between a field and the type whose children the XML writes, and the loader
# steps through both: Nullable<T>, and SlateRef<T> unless the text is a $variable.
function Resolve-Wrapper([Type]$t) {
    while ($t -and $t.IsGenericType) {
        $g = $t.GetGenericTypeDefinition()
        if ($g -eq [System.Nullable`1] -or $g.Name -eq 'SlateRef`1') { $t = $t.GetGenericArguments()[0] }
        else { break }
    }
    return $t
}

$script:fieldProblems = New-Object System.Collections.ArrayList
$script:defRefs       = New-Object System.Collections.ArrayList

function Add-DefRef([Type]$t, [string]$name, [string]$where) {
    if ([string]::IsNullOrWhiteSpace($name)) { return }
    [void]$script:defRefs.Add(@{ Type = $t.Name; Name = $name.Trim(); Where = $where })
}

function Test-LoaderShape($container, [string]$path, [Type]$elem) {
    foreach ($child in $container.ChildNodes) {
        if ($child.NodeType -ne 'Element' -or $child.LocalName -ne 'li') { continue }
        foreach ($grand in $child.ChildNodes) {
            if ($grand.NodeType -ne 'Element') { continue }
            [void]$script:fieldProblems.Add("$path/li/$($grand.LocalName)  -- $($elem.Name) is loaded by LoadDataFromXmlCustom; an <li> with children is the dictionary form, which RimWorld throws on")
            break
        }
    }
}

# The two custom-loader blocks this mod writes key their children by defName rather than by
# field, so the field walk cannot follow them - but the names are still references worth
# resolving: statBases names StatDefs and costList names ThingDefs.
$keyedByDefName = @{ 'StatModifier' = 'StatDef'; 'ThingDefCountClass' = 'ThingDef' }

function Walk($node, [Type]$t, [string]$path) {
    if (-not $t) { return }
    $fields = Get-FieldsRecursive $t
    foreach ($child in $node.ChildNodes) {
        if ($child.NodeType -ne 'Element') { continue }
        $n = $child.LocalName
        if ($n -eq 'li') { continue }

        $f = $null
        if ($fields.ContainsKey($n)) { $f = $fields[$n] }
        else { foreach ($k in $fields.Keys) { if ($k -ieq $n) { $f = $fields[$k]; break } } }
        if (-not $f) { [void]$script:fieldProblems.Add("$path/$n  -- no field '$n' on $($t.Name)"); continue }

        $ft = Resolve-Wrapper $f.FieldType
        if ($defType -and $defType.IsAssignableFrom($ft)) { Add-DefRef $ft $child.InnerText "$path/$n"; continue }
        if ($ft.IsPrimitive -or $ft -eq [string] -or $ft.IsEnum) { continue }

        if ($ft.IsGenericType -and $ft.GetGenericTypeDefinition() -eq [System.Collections.Generic.List`1]) {
            $elem = Resolve-Wrapper $ft.GetGenericArguments()[0]
            if ($defType -and $defType.IsAssignableFrom($elem)) {
                foreach ($li in $child.ChildNodes) {
                    if ($li.NodeType -eq 'Element') { Add-DefRef $elem $li.InnerText "$path/$n/li" }
                }
                continue
            }
            if ($elem.IsPrimitive -or $elem -eq [string] -or $elem.IsEnum) { continue }
            if (Test-CustomLoader $elem) {
                Test-LoaderShape $child "$path/$n" $elem
                if ($keyedByDefName.ContainsKey($elem.Name)) {
                    $kt = $byName[$keyedByDefName[$elem.Name]]
                    foreach ($k in $child.ChildNodes) {
                        if ($k.NodeType -eq 'Element' -and $k.LocalName -ne 'li') { Add-DefRef $kt $k.LocalName "$path/$n" }
                    }
                }
                continue
            }
            foreach ($li in $child.ChildNodes) {
                if ($li.NodeType -ne 'Element') { continue }
                $lt = $elem
                $cls = $li.GetAttribute('Class')
                if ($cls) { $short = $cls.Split('.')[-1]; if ($byName.ContainsKey($short)) { $lt = $byName[$short] } }
                Walk $li $lt "$path/$n/li"
            }
            continue
        }

        if (Test-CustomLoader $ft) { Test-LoaderShape $child "$path/$n" $ft; continue }

        $sub = $ft
        $cls = $child.GetAttribute('Class')
        if ($cls) { $short = $cls.Split('.')[-1]; if ($byName.ContainsKey($short)) { $sub = $byName[$short] } }
        Walk $child $sub "$path/$n"
    }
}

if ($byName.Count -gt 0) {
    foreach ($n in $defNodes) {
        $dt = $byName[$n.LocalName]
        if (-not $dt) { [void]$script:fieldProblems.Add("unknown def type <$($n.LocalName)>"); continue }
        Walk $n $dt "$($n.LocalName)/$($n.defName)"
    }
}

# ---------------------------------------------------------------------------------------------
# The game's data, indexed in one pass
# ---------------------------------------------------------------------------------------------
#
# Strings only, never the XML nodes: a node keeps its whole document alive, and there are some
# fifteen hundred of them under Data.

$vanilla      = @{}   # def type -> set of defName
$templates    = @{}   # ThingDef Name=   -> @{ Class; Parent }
$thingInfo    = @{}   # ThingDef defName -> @{ Class; Parent; Label }
$glowColors   = @{}   # every glowColor a vanilla CompProperties_Glower writes
$coreGivers   = @{}   # Core JoyGiverDef defName -> @{ Kind; Things }

foreach ($dir in (Get-ChildItem $GameData -Directory)) {
    $defsRoot = Join-Path $dir.FullName 'Defs'
    if (-not (Test-Path $defsRoot)) { continue }
    foreach ($f in Get-ChildItem $defsRoot -Recurse -Filter *.xml) {
        $x = New-Object System.Xml.XmlDocument
        try { $x.Load($f.FullName) } catch { continue }
        if ($null -eq $x.DocumentElement -or $x.DocumentElement.LocalName -ne 'Defs') { continue }
        foreach ($n in $x.DocumentElement.ChildNodes) {
            if ($n.NodeType -ne 'Element') { continue }
            $type   = $n.LocalName
            $dnNode = $n.SelectSingleNode('defName')
            if ($dnNode) {
                if (-not $vanilla.ContainsKey($type)) { $vanilla[$type] = @{} }
                $vanilla[$type][$dnNode.InnerText] = $true
            }
            if ($type -eq 'ThingDef') {
                $cls = $n.SelectSingleNode('thingClass')
                $lbl = $n.SelectSingleNode('label')
                $info = @{
                    Class  = $(if ($cls) { $cls.InnerText } else { $null })
                    Parent = $n.GetAttribute('ParentName')
                    Label  = $(if ($lbl) { $lbl.InnerText } else { $null })
                }
                $nm = $n.GetAttribute('Name')
                if ($nm)     { $templates[$nm] = $info }
                if ($dnNode) { $thingInfo[$dnNode.InnerText] = $info }
                foreach ($g in $n.SelectNodes('.//li[@Class="CompProperties_Glower"]/glowColor')) {
                    $glowColors[$g.InnerText] = $true
                }
            }
            if ($type -eq 'JoyGiverDef' -and $dir.Name -eq 'Core') {
                $td = $n.SelectSingleNode('thingDefs')
                $jk = $n.SelectSingleNode('joyKind')
                if ($td -and $jk) {
                    $coreGivers[[string]$n.defName] = @{
                        Kind   = $jk.InnerText
                        Things = @($td.ChildNodes | Where-Object { $_.NodeType -eq 'Element' } | ForEach-Object { $_.InnerText })
                    }
                }
            }
        }
    }
}

# The thingClass a ThingDef ends up with, walking ParentName up the vanilla templates. The mod's
# own ThingDef sets no thingClass at all, so this is the only way to know what the game will
# instantiate - and the whole mod rests on the answer.
function Resolve-ThingClass($info) {
    $hops = 0
    while ($info -and $hops -lt 12) {
        if ($info.Class) { return $info.Class }
        if (-not $info.Parent) { return $null }
        $info = $templates[$info.Parent]
        $hops++
    }
    return $null
}

function Test-VanillaDef([string]$type, [string]$name) {
    return ($vanilla.ContainsKey($type) -and $vanilla[$type].ContainsKey($name))
}

# A def of THIS mod that answers to a reference, by name AND by type. The name alone is not enough
# here: the job and the giver deliberately share CB_GazeIntoCrystalBall, so with the JobDef deleted
# the giver's jobDef reference would still find "a def of that name" - the giver itself. A
# reference typed as a base class is satisfied by any def of a subclass, as the loader would.
function Test-ModDef([string]$refType, [string]$name) {
    if (-not $modDefs.ContainsKey($name)) { return $false }
    $want = $byName[$refType]
    foreach ($kind in $modDefs[$name]) {
        if ($kind -eq $refType) { return $true }
        $have = $byName[$kind]
        if ($want -and $have -and $want.IsAssignableFrom($have)) { return $true }
    }
    return $false
}

# ---------------------------------------------------------------------------------------------

Write-Output 'Crystal Ball - test suite'
Write-Output "  mod        $ModRoot"
Write-Output "  game data  $GameData"
Write-Output ("  indexed    {0} def types and {1} building templates from the game, {2} game classes" -f `
              $vanilla.Count, $templates.Count, $byName.Count)
Write-Output ("  defs       {0} file(s), {1} def(s), {2} def reference(s) collected" -f `
              $defFiles.Count, $defNodes.Count, $script:defRefs.Count)
if ($byName.Count -eq 0) { Write-Output '  NOTE       Assembly-CSharp could not be loaded; the reflection tests will fail' }

# =============================================================================================
Section 'About and images'
# =============================================================================================

$aboutPath = Join-Path $modDir 'About\About.xml'
$about = $null
if (Test-Path $aboutPath) {
    try { $about = New-Object System.Xml.XmlDocument; $about.Load($aboutPath) } catch { $about = $null }
}

It 'About.xml parses, and keeps the identity that must never change' {
    if ($null -eq $about) { 'About.xml is missing or malformed'; return }
    $id = [string]$about.ModMetaData.packageId
    if ($id -ne 'nelim.crystalball') { "packageId is '$id'" }
    if ([string]$about.ModMetaData.name -ne 'Crystal Ball') { "name is '$($about.ModMetaData.name)'" }
    $vs = @($about.ModMetaData.supportedVersions.li | ForEach-Object { [string]$_ })
    if ($vs -notcontains '1.6') { "supportedVersions is '$($vs -join ', ')'" }
    $url = [string]$about.ModMetaData.url
    if ($url -ne 'https://github.com/vbardales/Rimworld-Crystal-Ball') { "url is '$url'" }
}

# PNG carries its size in the IHDR chunk, bytes 16..23, big-endian. Reading it by hand keeps the
# suite free of an image library for two numbers.
function Get-PngSize([string]$path) {
    $b = [System.IO.File]::ReadAllBytes($path)
    if ($b.Length -lt 24) { return $null }
    $w = [int]$b[16] * 16777216 + [int]$b[17] * 65536 + [int]$b[18] * 256 + [int]$b[19]
    $h = [int]$b[20] * 16777216 + [int]$b[21] * 65536 + [int]$b[22] * 256 + [int]$b[23]
    return @{ W = $w; H = $h; KB = [math]::Round($b.Length / 1KB) }
}

It 'Preview.png is 896 x 504 and stays under 900 KB' {
    $p = Join-Path $modDir 'About\Preview.png'
    if (-not (Test-Path $p)) { 'Preview.png is missing'; return }
    $s = Get-PngSize $p
    if ($s.W -ne 896 -or $s.H -ne 504) { "it is $($s.W) x $($s.H)" }
    if ($s.KB -gt 900) { "it weighs $($s.KB) KB" }
}

It 'ModIcon.png is 128 x 128 and stays under 30 KB' {
    $p = Join-Path $modDir 'About\ModIcon.png'
    if (-not (Test-Path $p)) { 'ModIcon.png is missing'; return }
    $s = Get-PngSize $p
    if ($s.W -ne 128 -or $s.H -ne 128) { "it is $($s.W) x $($s.H)" }
    if ($s.KB -gt 30) { "it weighs $($s.KB) KB" }
}

It 'the texture the def names is there, spelt the way the file is, square, and a power of two' {
    # Spelt the way the file is, segment by segment, because Test-Path alone would never catch
    # the fault this guards against: Windows finds Crystalball.png when the def asks for
    # CrystalBall, and Linux does not, so the mod ships with an invisible building for half its
    # players and nothing in the log.
    if (-not $ballNode) { 'the crystal ball def is missing'; return }
    $tex = $ballNode.SelectSingleNode('graphicData/texPath')
    if (-not $tex) { 'the def declares no texPath'; return }
    $segments = @($tex.InnerText.Split('/'))
    $segments[-1] = $segments[-1] + '.png'
    $here = Join-Path $modDir 'Textures'
    foreach ($seg in $segments) {
        $match = @(Get-ChildItem $here -Force | Where-Object { $_.Name -ceq $seg })
        if ($match.Count -eq 0) {
            $near = @(Get-ChildItem $here -Force | Where-Object { $_.Name -ieq $seg })
            if ($near.Count -gt 0) { "the def asks for '$seg' where the file is '$($near[0].Name)'" }
            else { "no '$seg' under $here" }
            return
        }
        $here = $match[0].FullName
    }
    $s = Get-PngSize $here
    if ($s.W -ne $s.H) { "it is $($s.W) x $($s.H), not square" }
    if (($s.W -band ($s.W - 1)) -ne 0) { "its side is $($s.W), not a power of two" }
}

It 'the cost the showcase text claims is the cost the def charges' {
    # The kind of drift a reader meets before any player does, and this mod has already had one
    # of them, in the preview image. The Workshop description and the README both repeat the
    # price, so both are read back against the def - and the material's name comes from the game
    # data rather than from a word typed here.
    if (-not $ballNode) { 'the crystal ball def is missing'; return }
    $cost = $ballNode.SelectSingleNode('costList')
    if (-not $cost) { 'the def has no costList'; return }
    $texts = @{}
    if ($null -ne $about) { $texts['About.xml'] = [string]$about.ModMetaData.description }
    $readme = Join-Path $ModRoot 'README.md'
    if (Test-Path $readme) { $texts['README.md'] = (Get-Content $readme -Raw) }
    foreach ($c in $cost.ChildNodes) {
        if ($c.NodeType -ne 'Element') { continue }
        $info = $thingInfo[$c.LocalName]
        if (-not $info -or -not $info.Label) { "costList names $($c.LocalName), which the game data does not label"; continue }
        foreach ($k in ($texts.Keys | Sort-Object)) {
            if ($texts[$k] -notmatch [regex]::Escape($info.Label)) { "$k never mentions $($info.Label)"; continue }
            # Neither text is made to quote a price. The Workshop description says "jade and a
            # little gold" and is the better for it; what is required is that a number written in
            # front of the material is the number the def charges.
            foreach ($m in [regex]::Matches($texts[$k], '(\d+)\s+' + [regex]::Escape($info.Label))) {
                if ($m.Groups[1].Value -ne $c.InnerText) {
                    "$k says '$($m.Value)' where the def charges $($c.InnerText)"
                }
            }
        }
    }
}

# =============================================================================================
Section 'The defs'
# =============================================================================================

It 'every def file parses' {
    foreach ($f in $defFiles) { if ($null -eq $docs[$f.FullName]) { "malformed: $($f.Name)" } }
}

It 'every def has a defName, and every defName carries the CB_ prefix' {
    foreach ($n in $defNodes) {
        $dn = [string]$n.defName
        if ([string]::IsNullOrWhiteSpace($dn)) { "a $($n.LocalName) has no defName"; continue }
        if (-not $dn.StartsWith('CB_')) { "$dn does not start with CB_" }
    }
}

It 'no defName is used twice for the same kind of def' {
    # Twice across kinds is deliberate here - the job and the giver are both
    # CB_GazeIntoCrystalBall, as vanilla's chess pair is - but twice within one kind is the
    # collision where the second def silently replaces the first.
    $seen = @{}
    foreach ($n in $defNodes) {
        $k = "$($n.LocalName)/$($n.defName)"
        if ($seen.ContainsKey($k)) { "$k is declared twice" }
        $seen[$k] = $true
    }
}

It 'every element maps to a field the 1.6 classes still have' {
    # RimWorld does not stop on an element that matches no field: it logs one line and carries on
    # with the field unset, so the def loads, works, and is quietly wrong.
    if ($byName.Count -eq 0) { 'Assembly-CSharp is not loaded'; return }
    foreach ($p in ($script:fieldProblems | Sort-Object -Unique)) { $p }
}

It 'every C# class the defs name resolves, and to the right kind of class' {
    if ($byName.Count -eq 0) { 'Assembly-CSharp is not loaded'; return }
    $expected = @{
        'graphicClass' = 'Graphic'
        'compClass'    = 'ThingComp'
        'driverClass'  = 'JobDriver'
        'giverClass'   = 'JoyGiver'
    }
    foreach ($n in $defNodes) {
        foreach ($e in $n.SelectNodes('.//*')) {
            $named  = $null
            $wanted = $null
            if ($expected.ContainsKey($e.LocalName)) {
                $named  = $e.InnerText
                $wanted = $expected[$e.LocalName]
            } else {
                $named = $e.GetAttribute('Class')
                if ($named -and $e.ParentNode.LocalName -eq 'comps') { $wanted = 'CompProperties' }
            }
            if ([string]::IsNullOrWhiteSpace($named)) { continue }
            $t = $byName[$named]
            if (-not $t) { $t = $byName[$named.Split('.')[-1]] }
            if (-not $t) { "$($n.defName): no class named $named"; continue }
            if ($wanted) {
                $base = $byName[$wanted]
                if ($base -and -not $base.IsAssignableFrom($t)) { "$($n.defName): $named is not a $wanted" }
            }
        }
    }
}

It 'every def the mod points at exists, here or in the game' {
    if ($byName.Count -eq 0) { 'Assembly-CSharp is not loaded'; return }
    if ($script:defRefs.Count -eq 0) { 'not one def reference was collected, which cannot be right'; return }
    foreach ($r in $script:defRefs) {
        if (Test-ModDef $r.Type $r.Name) { continue }
        if (Test-VanillaDef $r.Type $r.Name) { continue }
        "$($r.Where): no $($r.Type) named $($r.Name)"
    }
}

It 'the template the ThingDef inherits from is one the game defines' {
    if (-not $ballNode) { 'the crystal ball def is missing'; return }
    $p = $ballNode.GetAttribute('ParentName')
    if (-not $p) { 'the def inherits from nothing, so it would carry no thingClass at all'; return }
    if (-not $templates.ContainsKey($p)) { "no vanilla ThingDef is named $p" }
}

# =============================================================================================
Section 'The rules this mod rests on'
# =============================================================================================

It 'the ball is a Building, which is the cast the vanilla driver makes' {
    # The mod ships no code because JobDriver_SitFacingBuilding works here unmodified. The
    # driver's own accessor is typed Building, so anything else raises an InvalidCastException
    # the moment a pawn sits down - which is what happens to an anima tree, a Plant.
    if ($byName.Count -eq 0) { 'Assembly-CSharp is not loaded'; return }
    if (-not $ballNode) { 'the crystal ball def is missing'; return }
    $driver = $byName['JobDriver_SitFacingBuilding']
    if (-not $driver) { 'the game has no JobDriver_SitFacingBuilding any more'; return }
    $prop = $driver.GetProperty('Building', [System.Reflection.BindingFlags]'Public,NonPublic,Instance')
    if (-not $prop) { 'JobDriver_SitFacingBuilding no longer exposes a Building'; return }
    $own = $ballNode.SelectSingleNode('thingClass')
    $info = @{
        Class  = $(if ($own) { $own.InnerText } else { $null })
        Parent = $ballNode.GetAttribute('ParentName')
    }
    $className = Resolve-ThingClass $info
    if (-not $className) { 'the def resolves to no thingClass through its parents'; return }
    $t = $byName[$className]
    if (-not $t) { "no class named $className"; return }
    if (-not $prop.PropertyType.IsAssignableFrom($t)) {
        "the def loads as $className, which the driver cannot cast to $($prop.PropertyType.Name)"
    }
}

It 'no chair is needed, and that is the field the vanilla giver reads' {
    # requireChair defaults to true. Left out, the giver would look for a chair next to the ball
    # and a fortune teller's caravan would stand unused forever.
    if (-not $giverNode) { 'the joy giver is missing'; return }
    $rc = $giverNode.SelectSingleNode('requireChair')
    if (-not $rc) { 'requireChair is not declared, and it defaults to true'; return }
    if ($rc.InnerText -notmatch '^(?i)false$') { "requireChair is '$($rc.InnerText)'" }
    if ($byName.Count -gt 0 -and -not (Get-FieldsRecursive $byName['JoyGiverDef']).ContainsKey('requireChair')) {
        'JoyGiverDef has no requireChair field any more'
    }
}

It 'the building, the job and the giver all name the same recreation type' {
    # Three declarations of one thing. Let them drift and a colonist walks to the ball, gazes,
    # and comes away with a kind of recreation the mod never meant to serve.
    $where = @{
        "the building's" = $(if ($ballNode)  { $ballNode.SelectSingleNode('building/joyKind') })
        "the job's"      = $(if ($jobNode)   { $jobNode.SelectSingleNode('joyKind') })
        "the giver's"    = $(if ($giverNode) { $giverNode.SelectSingleNode('joyKind') })
    }
    foreach ($k in ($where.Keys | Sort-Object)) {
        if (-not $where[$k]) { "$k joyKind is missing"; continue }
        if ($where[$k].InnerText -ne 'CB_Divination') { "$k joyKind is $($where[$k].InnerText)" }
    }
    if ($giverNode) {
        $things = @($giverNode.SelectNodes('thingDefs/li') | ForEach-Object { $_.InnerText })
        if ($things -notcontains 'CB_CrystalBall') { "the giver's thingDefs are '$($things -join ', ')'" }
        $jd = $giverNode.SelectSingleNode('jobDef')
        if (-not $jd -or $jd.InnerText -ne 'CB_GazeIntoCrystalBall') { 'the giver does not point at this mod''s job' }
    }
}

It 'divination is an eleventh recreation type, not one the game already has' {
    # Counted from the game rather than copied into a table: the day a RimWorld release adds a
    # kind, the README's arithmetic changes and this test is what says so.
    if (-not $vanilla.ContainsKey('JoyKindDef')) { 'no JoyKindDef found in the game data'; return }
    $n = $vanilla['JoyKindDef'].Count
    if ($n -ne 10) { "the game now ships $n recreation types, so the README's ten is stale" }
    if ($kindNodes.Count -eq 0) { 'the mod declares no JoyKindDef of its own'; return }
    foreach ($k in $kindNodes) {
        if ($vanilla['JoyKindDef'].ContainsKey([string]$k.defName)) {
            "$($k.defName) is a kind the game already ships, so this replaces one rather than adding an eleventh"
        }
    }
}

It 'only four of those ten come from a building, as the README says' {
    $kinds = @{}
    foreach ($g in $coreGivers.Values) {
        foreach ($thing in $g.Things) {
            $info = $thingInfo[$thing]
            if (-not $info) { continue }
            if ((Resolve-ThingClass $info) -eq 'Building') { $kinds[$g.Kind] = $true }
        }
    }
    if ($kinds.Count -ne 4) {
        "the base game now serves $($kinds.Count) recreation types from a building: $(($kinds.Keys | Sort-Object) -join ', ')"
    }
}

It 'a kind served by a building does not declare needsThing false' {
    # needsThing defaults to true, and vanilla only turns it off for the two kinds that need no
    # object at all. Turned off here, a colonist would satisfy divination out of thin air and the
    # ball would never be visited.
    if (-not $kindNode) { 'the mod declares no JoyKindDef'; return }
    $nt = $kindNode.SelectSingleNode('needsThing')
    if ($nt -and $nt.InnerText -notmatch '^(?i)true$') { "needsThing is '$($nt.InnerText)'" }
}

It 'the thing categories travel with a minifiedDef' {
    # A def with thingCategories and no minifiedDef raises "is not minifiable yet has thing
    # categories" at load. The two go together, or neither is written.
    if (-not $ballNode) { 'the crystal ball def is missing'; return }
    $cats = $ballNode.SelectSingleNode('thingCategories')
    $mini = $ballNode.SelectSingleNode('minifiedDef')
    if ($cats -and -not $mini) { 'thingCategories without minifiedDef: the def fails its config check' }
    if ($mini -and -not $cats) { 'minifiedDef without thingCategories: the minified thing would land nowhere' }
}

It 'the glow keeps the zero alpha every vanilla glower writes' {
    if (-not $ballNode) { 'the crystal ball def is missing'; return }
    $g = $ballNode.SelectSingleNode('.//li[@Class="CompProperties_Glower"]/glowColor')
    if (-not $g) { 'the def declares no glowColor'; return }
    $alphas = @{}
    foreach ($v in $glowColors.Keys) {
        $parts = $v.Trim('(', ')', ' ').Split(',')
        if ($parts.Count -ge 4) { $alphas[$parts[3].Trim()] = $true }
    }
    if ($alphas.Count -ne 1) { "vanilla writes more than one alpha: $(($alphas.Keys | Sort-Object) -join ', ')"; return }
    $mine = $g.InnerText.Trim('(', ')', ' ').Split(',')
    if ($mine.Count -lt 4) { "glowColor is '$($g.InnerText)', which carries no alpha"; return }
    $only = @($alphas.Keys)[0]
    if ($mine[3].Trim() -ne $only) { "glowColor's alpha is $($mine[3].Trim()) where every vanilla glower writes $only" }
}

# =============================================================================================
Section 'Translations'
# =============================================================================================

$frRoot = Join-Path $modDir 'Languages\French\DefInjected'
$frKeys = @{}
if (Test-Path $frRoot) {
    foreach ($f in Get-ChildItem $frRoot -Recurse -Filter *.xml) {
        $folder = Split-Path (Split-Path $f.FullName -Parent) -Leaf
        $x = New-Object System.Xml.XmlDocument
        try { $x.Load($f.FullName) } catch { continue }
        if ($null -eq $x.DocumentElement) { continue }
        foreach ($k in $x.DocumentElement.ChildNodes) {
            if ($k.NodeType -eq 'Element') { $frKeys["$folder/$($k.LocalName)"] = $k.InnerText }
        }
    }
}

It 'every string the game marks [MustTranslate] has a French key' {
    # Which strings those are is read off the 1.6 classes, not listed here: a field the game
    # starts translating one day is picked up without this suite being touched.
    if ($byName.Count -eq 0) { 'Assembly-CSharp is not loaded'; return }
    foreach ($n in $defNodes) {
        $t = $byName[$n.LocalName]
        if (-not $t) { continue }
        $fields = Get-FieldsRecursive $t
        foreach ($child in $n.ChildNodes) {
            if ($child.NodeType -ne 'Element') { continue }
            $f = $fields[$child.LocalName]
            if (-not $f -or $f.FieldType -ne [string]) { continue }
            $must = $false
            foreach ($a in $f.CustomAttributes) { if ($a.AttributeType.Name -eq 'MustTranslateAttribute') { $must = $true } }
            if (-not $must) { continue }
            $key = "$($n.LocalName)/$($n.defName).$($f.Name)"
            if (-not $frKeys.ContainsKey($key)) { "French has no $key" }
        }
    }
}

It 'every French key names a def of this mod and a field that def has' {
    if ($byName.Count -eq 0) { 'Assembly-CSharp is not loaded'; return }
    if ($frKeys.Count -eq 0) { 'not one French key was read'; return }
    foreach ($k in $frKeys.Keys) {
        $folder = $k.Split('/', 2)[0]
        $rest   = $k.Split('/', 2)[1]
        $dot = $rest.LastIndexOf('.')
        if ($dot -lt 1) { "$k is not a defName.field handle"; continue }
        $defName = $rest.Substring(0, $dot)
        $field   = $rest.Substring($dot + 1)
        if (-not (Get-ModDef $folder $defName)) { "$k names no $folder called $defName in this mod"; continue }
        $t = $byName[$folder]
        if (-not $t) { "$k sits in a folder named after no class"; continue }
        if (-not (Get-FieldsRecursive $t).ContainsKey($field)) { "$k names no field '$field' on $folder" }
    }
}

It 'each DefInjected folder is spelled the way its class is' {
    # A miscased folder is found on Windows and missed on Linux, where the file goes unread and
    # the language falls back to English without a word in the log.
    if ($byName.Count -eq 0) { 'Assembly-CSharp is not loaded'; return }
    if (-not (Test-Path $frRoot)) { 'there is no French DefInjected directory'; return }
    foreach ($d in Get-ChildItem $frRoot -Directory) {
        $t = $byName[$d.Name]
        if (-not $t) { "$($d.Name) is no class of the game"; continue }
        if ($t.Name -cne $d.Name) { "$($d.Name) should be spelled $($t.Name)" }
    }
}

It 'no French value is empty, and the description keeps its paragraph breaks' {
    foreach ($k in ($frKeys.Keys | Sort-Object)) {
        if ([string]::IsNullOrWhiteSpace($frKeys[$k])) { "$k is empty" }
    }
    $fr = $frKeys['ThingDef/CB_CrystalBall.description']
    if ($ballNode -and $fr) {
        $en = $ballNode.SelectSingleNode('description')
        if ($en) {
            $enBreaks = ([regex]::Matches($en.InnerText, '\\n')).Count
            $frBreaks = ([regex]::Matches($fr, '\\n')).Count
            if ($enBreaks -ne $frBreaks) { "the English description has $enBreaks line breaks, the French one $frBreaks" }
        }
    }
}

# =============================================================================================

Write-Output ''
if ($script:failed -eq 0) {
    Write-Output "$($script:ran) tests, all passing."
} else {
    Write-Output "$($script:ran) tests, $($script:failed) failing."
}

[System.AppDomain]::CurrentDomain.remove_AssemblyResolve($script:asmResolver)
exit ([int]($script:failed -gt 0))
