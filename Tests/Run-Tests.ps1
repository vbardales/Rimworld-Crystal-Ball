<#
.SYNOPSIS
  The mod's own tests: values and behaviours no shared check holds. Runs without RimWorld, in a few seconds.

.DESCRIPTION
  The mod ships no assembly, so there is no mod C# to instantiate. What takes its place is the
  vanilla side: the suite loads Assembly-CSharp by reflection and asks the game's own classes
  what this mod is allowed to assume.

  What the shared checks already do is not repeated here: XML parse, defName uniqueness, images,
  About.xml shape (Check-ModBasics), reference and class resolution (Check-DefRefs, Check-TypeRefs),
  field names (Check-XmlFields), French coverage and keys (Check-Translations, Check-DefInjected).

  Three groups:

    Identity and cost  the identity that must never change, and the cost the showcase text claims
                       against the cost the def charges
    The defs           the CB_ prefix, and everything the mod points at defined in Core
    The rules          the things this mod rests on, each tested against the game rather than
                       against its own prose

  The third group encodes sentences the README states as fact, and computes them from the game:

    - "it works because a crystal ball is a Building" is checked by resolving the def's
      thingClass through the vanilla parent chain and comparing it with the return type of
      JobDriver_SitFacingBuilding.Building.
    - "an eleventh recreation type" is checked by counting the vanilla JoyKindDefs.
    - "only four of the ten come from a building" is computed from Core's JoyGiverDefs that
      name a building.
    - "no chair needed" is checked as the field the vanilla giver actually reads.
    - the glow's zero alpha is checked against every CompProperties_Glower in the game data.

  Exit code 0 when everything passes, 1 otherwise. Output uses Write-Output, never Write-Host.

.EXAMPLE
  powershell -NoProfile -ExecutionPolicy Bypass -File Tests/Run-Tests.ps1
#>

param(
    [string]$ModRoot  = (Split-Path -Parent $PSScriptRoot),
    [string]$GameData = 'C:\Program Files (x86)\Steam\steamapps\common\RimWorld\Data',
    [string]$Managed  = 'C:\Program Files (x86)\Steam\steamapps\common\RimWorld\RimWorldWin64_Data\Managed'
)

$ErrorActionPreference = 'Stop'

# ---------------------------------------------------------------------------------------------

# Shared harness (protocols checkout, two levels above the mod): the test runner and the game-reflection library.
. "$PSScriptRoot\..\..\scripts\lib\TestRunner.ps1"
. "$PSScriptRoot\..\..\scripts\lib\GameReflection.ps1"

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

Initialize-GameReflection -Managed $Managed

$byName  = @{}
$asmPath = Join-Path $Managed 'Assembly-CSharp.dll'
if (Test-Path $asmPath) { $byName = New-TypeIndex @(Get-AssemblyTypes $asmPath) }
$defType = $byName['Verse.Def']

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
$vanillaHome  = @{}   # "Type/defName"   -> the data folders that define it (Core, Royalty, ...)
$templateHome = @{}   # ThingDef Name=   -> the data folders that define that template
$coreClasses  = @{}   # every C# class a Core def names: giverClass, driverClass, compClass, graphicClass,
                      # thingClass, and any Class= attribute

# Every C# class a def node names, in the five elements that take a class and in any Class= attribute,
# the node's own and its descendants'. Used on the game's Core defs and on this mod's, so that "a class
# the mod names" and "a class Core names" are the same question asked the same way.
function Get-NamedClasses($node) {
    $names = @{}
    foreach ($c in $node.SelectNodes('.//giverClass | .//driverClass | .//compClass | .//graphicClass | .//thingClass')) {
        if ($c.InnerText.Trim()) { $names[$c.InnerText.Trim()] = $true }
    }
    foreach ($a in $node.SelectNodes('.//@Class')) { if ($a.Value.Trim()) { $names[$a.Value.Trim()] = $true } }
    $own = $node.GetAttribute('Class')
    if ($own) { $names[$own.Trim()] = $true }
    return @($names.Keys)
}
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
                $hk = "$type/$($dnNode.InnerText)"
                if (-not $vanillaHome.ContainsKey($hk)) { $vanillaHome[$hk] = @{} }
                $vanillaHome[$hk][$dir.Name] = $true
            }
            if ($dir.Name -eq 'Core') {
                foreach ($c in (Get-NamedClasses $n)) { $coreClasses[$c] = $true }
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
                if ($nm) {
                    $templates[$nm] = $info
                    if (-not $templateHome.ContainsKey($nm)) { $templateHome[$nm] = @{} }
                    $templateHome[$nm][$dir.Name] = $true
                }
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

# ---------------------------------------------------------------------------------------------

Write-Output 'Crystal Ball - test suite'
Write-Output "  mod        $ModRoot"
Write-Output "  game data  $GameData"
Write-Output ("  indexed    {0} def types and {1} building templates from the game, {2} game classes" -f `
              $vanilla.Count, $templates.Count, $byName.Count)
Write-Output ("  defs       {0} file(s), {1} def(s)" -f $defFiles.Count, $defNodes.Count)
if ($byName.Count -eq 0) { Write-Output '  NOTE       Assembly-CSharp could not be loaded; the reflection tests will fail' }

# =============================================================================================
Section 'Identity and cost'
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

It 'every def has a defName, and every defName carries the CB_ prefix' {
    foreach ($n in $defNodes) {
        $dn = [string]$n.defName
        if ([string]::IsNullOrWhiteSpace($dn)) { "a $($n.LocalName) has no defName"; continue }
        if (-not $dn.StartsWith('CB_')) { "$dn does not start with CB_" }
    }
}

# =============================================================================================

It 'everything the mod points at is defined in Core, so no DLC is required' {
    # "No DLC required" is a claim the description and the README make. A reference is any element text, or the element name inside costList or statBases,
    # that is the defName of a game def (those two blocks key their entries by defName). Each must be defined in Core, every template the def inherits must be a Core one, and

    # every C# class it names must be one a Core def names: a DLC-only class fails, and so would a Core class no
    # Core def happens to name, which is the fault to look at rather than to wave through.
    if ($vanillaHome.Count -eq 0) { 'the game data holds no def at all'; return }
    if ($coreClasses.Count -eq 0) { 'Core names no C# class at all, which cannot be right'; return }
    $homeByName = @{}
    foreach ($k in $vanillaHome.Keys) {
        $nm = $k.Substring($k.IndexOf('/') + 1)
        if (-not $homeByName.ContainsKey($nm)) { $homeByName[$nm] = @{} }
        foreach ($d in $vanillaHome[$k].Keys) { $homeByName[$nm][$d] = $true }
    }
    foreach ($n in $defNodes) {
        $seen = @{}
        foreach ($e in $n.SelectNodes('.//*')) {
            $leaf = -not ($e.ChildNodes | Where-Object { $_.NodeType -eq 'Element' })
            $keyed = $e.ParentNode.LocalName -in @('costList', 'statBases')
            foreach ($cand in @($(if ($keyed) { $e.LocalName }), $(if ($leaf) { $e.InnerText.Trim() }))) {
                if (-not $cand -or $seen.ContainsKey($cand) -or $modDefs.ContainsKey($cand)) { continue }
                $seen[$cand] = $true
                $folders = $homeByName[$cand]
                if ($folders -and -not $folders.ContainsKey('Core')) {
                    "$($n.defName): $cand is defined only in $((@($folders.Keys) | Sort-Object) -join ', ')"
                }
            }
        }
        $p = $n.GetAttribute('ParentName')
        if ($p -and $templateHome.ContainsKey($p) -and -not $templateHome[$p].ContainsKey('Core')) {
            "$($n.defName): the template $p is defined only in $((@($templateHome[$p].Keys) | Sort-Object) -join ', ')"
        }
        foreach ($c in (Get-NamedClasses $n)) {
            if (-not $coreClasses.ContainsKey($c)) { "$($n.defName): the class $c is named by no Core def, so it may belong to a DLC" }
        }
    }
}

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


Remove-GameReflection
Complete-Tests
