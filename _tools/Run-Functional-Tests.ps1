<#
.SYNOPSIS
  What the game actually does with this mod's defs, checked outside the game.

.DESCRIPTION
  Run-Tests.ps1 next door checks that the defs are well formed and that what the README says about
  RimWorld is still true. This one asks a different question: the mod ships no code, so it hands
  its whole behaviour to vanilla classes - do those classes still do what it hands it to them for?

  Nothing here is simulated. RimWorld cannot be run outside itself - most of its types touch Unity
  and throw on construction, its XML loader among them - but three things do work, and they are
  enough:

    reading IL       a method body comes back as bytes through plain reflection, and the tokens
                     in it resolve. That is how the cast the whole mod rests on is read off the
                     compiled game rather than asserted.
    reverse lookup   scanning every method of Assembly-CSharp for the field tokens this mod
                     writes says WHO reads each of its settings. Two to three seconds for
                     16 000 types.
    construction     the classes without Unity state - JoyGiverDef, JobDef, the giver, the driver
                     - really are instantiated here, through the game's own accessors.

  Eleven tests, in four groups:

    Built by the game    the giver and the driver this mod names, instantiated for real
    Every setting read   no setting inert, and each read by the class this mod chose
    The type             what makes an eleventh recreation type worth having, traced to the
                         methods that count it
    The numbers          against the vanilla defs that run on the same driver and giver

  Two findings worth keeping, both from writing this:

    - JoyGiverDef.requireChair is read by exactly one class in the game,
      JoyGiver_InteractBuildingSitAdjacent, which is the one this mod names. Point the def at
      another giver and the setting goes silently inert - no error, no log line, and pawns that
      refuse to use the building for want of a chair that is not there.
    - the game keeps fields nothing reads any more. Seven public fields of ThingDef, GraphicData
      and BuildingProperties have no reader left in 1.6: ThingDef.pathfinderDangerous,
      GraphicData.overlayOpacity, GraphicData.name, BuildingProperties.workTableCompleteSoundDef,
      trapUnarmedGraphic, trapUnarmedGraphicData and mineableNonMinedEfficiency. A mod that writes
      one of those is writing a comment, so the suite says so.
    - and one way to get that list wrong. A first scan matched ldfld only and reported fourteen,
      because a struct field is read by address (ldflda) whenever a method is called on it:
      ThingDef.startingHpRange and displayNumbersBetweenSameDefDistRange, highlightColor,
      BuildingProperties.turretTopOffset, turretBurstWarmupTime, maxFormedMechDrawSize and
      barDrawData are all read. Both loads are matched now, and a field written as
      <startingHpRange> is the fault that was used to see it.

  Exit code 0 when everything passes, 1 otherwise. Three to eight seconds, cold or warm, two to
  three of them the scan.

  EVERY TEST HERE HAS BEEN SEEN TO FAIL, the same way as next door: one fault at a time in a copy
  of the mod in a scratch directory, never in the real files.

    giverClass pointed at a class that is no JoyGiver -> the Worker test, the settings test, and
                                                         the chance comparison
    driverClass pointed at the abstract JobDriver     -> the driver test, the cast test, the
                                                         two-settings test, both comparisons
    thingClass forced to Plant, the anima tree case   -> the cast test: "the driver casts to
                                                         Building and this def loads as Plant"
    pathfinderDangerous written                       -> the inert-setting test, alone
    startingHpRange written, a struct read by address -> nothing. It failed before ldflda was
                                                         matched, naming a field the game reads.
    giverClass moved to the telescope giver           -> the settings test, naming requireChair
                                                         and nothing else
    driverClass moved to the skygazing driver         -> the cast test and joyMaxParticipants
    the joyKind taken off the job                     -> the credit test
    the joyKind taken off the building                -> the tally test
    joyDuration raised to 12000                       -> the length comparison, naming the 4000
                                                         its two vanilla cousins use
    joyMaxParticipants raised to 9                    -> the participants comparison
    baseChance raised to 40                           -> the chance comparison, naming 2 and 4

  The fifth of those is the one worth reading twice. Moving the def to another giver breaks
  nothing a validator could see: the class exists, the fields exist, the mod loads. Only
  requireChair goes quiet, and only this test says so.

.EXAMPLE
  powershell -NoProfile -ExecutionPolicy Bypass -File _tools/Run-Functional-Tests.ps1
#>

param(
    [string]$ModRoot  = (Split-Path -Parent $PSScriptRoot),
    [string]$GameData = 'C:\Program Files (x86)\Steam\steamapps\common\RimWorld\Data',
    [string]$Managed  = 'C:\Program Files (x86)\Steam\steamapps\common\RimWorld\RimWorldWin64_Data\Managed'
)

$ErrorActionPreference = 'Stop'

$script:ran = 0
$script:failed = 0

function It([string]$name, [scriptblock]$body) {
    $script:ran++
    $problems = @()
    try   { $problems = @(& $body | Where-Object { $_ }) }
    catch { $problems = @("threw: $($_.Exception.GetBaseException().Message)") }
    if ($problems.Count -eq 0) { Write-Output "  ok    $name" }
    else {
        $script:failed++
        Write-Output "  FAIL  $name"
        foreach ($p in $problems) { Write-Output "          $p" }
    }
}

function Section([string]$name) { Write-Output ''; Write-Output $name }

# ---------------------------------------------------------------------------------------------
# The game, loaded
# ---------------------------------------------------------------------------------------------

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

$allTypes = @()
$byName   = @{}
$asmPath  = Join-Path $Managed 'Assembly-CSharp.dll'
if (Test-Path $asmPath) {
    $allTypes = @(Get-AssemblyTypes $asmPath)
    foreach ($t in $allTypes) { if (-not $byName.ContainsKey($t.Name)) { $byName[$t.Name] = $t } }
}

$BFd = [System.Reflection.BindingFlags]'Public,NonPublic,Instance,DeclaredOnly'
$BFm = [System.Reflection.BindingFlags]'Public,NonPublic,Instance,Static,DeclaredOnly'

function Get-FieldsRecursive([Type]$t) {
    $d = @{}
    $cur = $t
    while ($cur -and $cur.FullName -ne 'System.Object') {
        foreach ($f in $cur.GetFields($BFd)) { if (-not $d.ContainsKey($f.Name)) { $d[$f.Name] = $f } }
        $cur = $cur.BaseType
    }
    return $d
}

function Get-Ancestry([Type]$t) {
    $names = @{}
    $cur = $t
    while ($cur -and $cur.FullName -ne 'System.Object') { $names[$cur.Name] = $true; $cur = $cur.BaseType }
    return $names
}

# ---------------------------------------------------------------------------------------------
# What the mod writes
# ---------------------------------------------------------------------------------------------

$modDir = Join-Path $ModRoot 'Mod'
$defDoc = New-Object System.Xml.XmlDocument
$defDoc.Load((Join-Path $modDir 'Defs\CrystalBall.xml'))

function Get-DefNode([string]$type) { return $defDoc.DocumentElement.SelectSingleNode($type) }

$ballNode  = Get-DefNode 'ThingDef'
$jobNode   = Get-DefNode 'JobDef'
$giverNode = Get-DefNode 'JoyGiverDef'

function Get-Text($node, [string]$xpath) {
    if (-not $node) { return $null }
    $n = $node.SelectSingleNode($xpath)
    if ($n) { return $n.InnerText.Trim() }
    return $null
}

$giverClassName  = Get-Text $giverNode 'giverClass'
$driverClassName = Get-Text $jobNode   'driverClass'

# Every field the defs set, resolved to the FieldInfo the loader would fill. The walk stops where
# Run-Tests.ps1's does, and for the same reasons: a list of defs is a list of names, and a type
# with a custom loader reads the XML itself.
$written = @{}     # metadata token -> "Type.field"
function Collect-Written($node, [Type]$t) {
    if (-not $t) { return }
    $fields = Get-FieldsRecursive $t
    foreach ($c in $node.ChildNodes) {
        if ($c.NodeType -ne 'Element' -or $c.LocalName -eq 'li') { continue }
        $f = $fields[$c.LocalName]
        if (-not $f) { continue }
        # Keyed by the type that DECLARES the field, not the one the XML node sits on. defName
        # written under a JoyGiverDef is Def.defName, read by half the game and a setting of
        # nobody's: the distinction is what lets the tests below single out the real settings.
        $written[$f.MetadataToken] = "$($f.DeclaringType.Name).$($f.Name)"
        $ft = $f.FieldType
        if ($ft.IsPrimitive -or $ft -eq [string] -or $ft.IsEnum -or $ft.IsGenericType) { continue }
        if ($byName['Def'].IsAssignableFrom($ft)) { continue }
        $sub = $ft
        $cls = $c.GetAttribute('Class')
        if ($cls -and $byName.ContainsKey($cls)) { $sub = $byName[$cls] }
        Collect-Written $c $sub
    }
}
if ($byName.Count -gt 0) {
    foreach ($n in $defDoc.DocumentElement.ChildNodes) {
        if ($n.NodeType -eq 'Element') { Collect-Written $n $byName[$n.LocalName] }
    }
    foreach ($li in $defDoc.DocumentElement.SelectNodes('.//comps/li')) {
        $cls = $li.GetAttribute('Class')
        $t = $(if ($cls -and $byName.ContainsKey($cls)) { $byName[$cls] } else { $byName['CompProperties'] })
        Collect-Written $li $t
    }
}

# Two fields the mod deliberately leaves at their default, and whose readers it still wants to
# name: the tally of recreation types available on the map consults both.
$extra = @{}
if ($byName.Count -gt 0) {
    $f = $byName['JoyKindDef'].GetField('needsThing', [System.Reflection.BindingFlags]'Public,NonPublic,Instance')
    if ($f) { $extra[$f.MetadataToken] = 'JoyKindDef.needsThing' }
}

# ---------------------------------------------------------------------------------------------
# Who reads what: one pass over every method body in the game
# ---------------------------------------------------------------------------------------------
#
# ldfld (0x7B) and ldflda (0x7C) carry a four-byte token. Inside one module that token IS the
# field's MetadataToken, so the whole scan is an integer comparison - no ResolveMember per
# instruction, which is what keeps it to a few seconds rather than an afternoon.
#
# The bytes are scanned, not decoded. A match needs the opcode byte followed by four bytes equal
# to a hunted token, and field tokens are 0x04xxxxxx, so an accidental hit inside another
# instruction's operand is not a realistic risk. Decoding would be the answer if it became one.
#
# The reader is recorded as the OUTERMOST declaring type. A driver's MakeNewToils compiles to a
# nested <MakeNewToils>d__5 state machine, and a lambda to a <>c: reporting those would name
# nothing a reader recognises, and there are several classes with a d__5.

$hunted = @{}
foreach ($k in $written.Keys) { $hunted[$k] = $written[$k] }
foreach ($k in $extra.Keys)   { $hunted[$k] = $extra[$k] }

$readers = @{}     # "Type.field" -> set of reader type names
$scanSeconds = 0
if ($hunted.Count -gt 0) {
    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    foreach ($t in $allTypes) {
        foreach ($m in (@($t.GetMethods($BFm)) + @($t.GetConstructors($BFm)))) {
            $body = $null
            try { $body = $m.GetMethodBody() } catch { }
            if (-not $body) { continue }
            $il = $body.GetILAsByteArray()
            if (-not $il -or $il.Length -lt 5) { continue }
            for ($i = 0; $i -lt $il.Length - 4; $i++) {
                # 0x7B is ldfld, 0x7C is ldflda. A struct field - a FloatRange, a Vector2 - is read
                # by ADDRESS whenever a method is called on it (startingHpRange.RandomInRange), so
                # matching ldfld alone reports it as read by nothing.
                if ($il[$i] -ne 0x7B -and $il[$i] -ne 0x7C) { continue }
                $tok = [BitConverter]::ToInt32($il, $i + 1)
                if (-not $hunted.ContainsKey($tok)) { continue }
                $owner = $t
                while ($owner.DeclaringType) { $owner = $owner.DeclaringType }
                $key = $hunted[$tok]
                if (-not $readers.ContainsKey($key)) { $readers[$key] = @{} }
                $readers[$key][$owner.Name] = $true
            }
        }
    }
    $sw.Stop()
    $scanSeconds = $sw.Elapsed.TotalSeconds
}

function Get-Readers([string]$field) {
    if ($readers.ContainsKey($field)) { return @($readers[$field].Keys | Sort-Object) }
    return @()
}

# Some of these fields are read in two hundred places. A failure has to stay readable.
function Show-Readers($names) {
    $a = @($names)
    if ($a.Count -le 6) { return ($a -join ', ') }
    return (($a[0..5] -join ', ') + " and $($a.Count - 6) more")
}

# ---------------------------------------------------------------------------------------------
# The vanilla defs that run on the same classes
# ---------------------------------------------------------------------------------------------

$vanillaJobs   = @{}    # defName -> @{ Driver; Duration; Participants }
$vanillaGivers = @{}    # defName -> @{ Giver; Chance }
foreach ($dir in (Get-ChildItem $GameData -Directory)) {
    $defsRoot = Join-Path $dir.FullName 'Defs'
    if (-not (Test-Path $defsRoot)) { continue }
    foreach ($f in Get-ChildItem $defsRoot -Recurse -Filter *.xml) {
        $x = New-Object System.Xml.XmlDocument
        try { $x.Load($f.FullName) } catch { continue }
        if ($null -eq $x.DocumentElement -or $x.DocumentElement.LocalName -ne 'Defs') { continue }
        foreach ($n in $x.DocumentElement.ChildNodes) {
            if ($n.NodeType -ne 'Element') { continue }
            if ($n.LocalName -eq 'JobDef') {
                $d = Get-Text $n 'driverClass'
                if ($d) { $vanillaJobs[[string]$n.defName] = @{
                    Driver       = $d
                    Duration     = Get-Text $n 'joyDuration'
                    Participants = Get-Text $n 'joyMaxParticipants' } }
            }
            if ($n.LocalName -eq 'JoyGiverDef') {
                $g = Get-Text $n 'giverClass'
                if ($g) { $vanillaGivers[[string]$n.defName] = @{ Giver = $g; Chance = Get-Text $n 'baseChance' } }
            }
        }
    }
}

# ---------------------------------------------------------------------------------------------

Write-Output 'Crystal Ball - what the game does with it'
Write-Output "  mod        $ModRoot"
Write-Output ("  scanned    {0} types for the readers of {1} field(s), in {2:n1}s" -f `
              $allTypes.Count, $hunted.Count, $scanSeconds)
Write-Output ("  vanilla    {0} jobs and {1} joy givers read from the game data" -f `
              $vanillaJobs.Count, $vanillaGivers.Count)

# =============================================================================================
Section 'Built by the game itself'
# =============================================================================================

It 'the giver this def names is one the game can build, and it comes back bound to the def' {
    # JoyGiverDef.Worker is the game's own accessor: it instantiates giverClass and sets the
    # worker's def to itself. Calling it here runs that code, so a giverClass that is not a
    # JoyGiver at all fails on the cast the way it would in game.
    if (-not $giverClassName) { 'the def names no giverClass'; return }
    $t = $byName[$giverClassName]
    if (-not $t) { "no class named $giverClassName"; return }
    $def = [Activator]::CreateInstance($byName['JoyGiverDef'])
    $def.giverClass = $t
    $worker = $def.Worker
    if ($null -eq $worker) { 'the Worker accessor returned nothing'; return }
    if ($worker.GetType() -ne $t) { "the worker is a $($worker.GetType().Name)" }
    if (-not [object]::ReferenceEquals($worker.def, $def)) { 'the worker came back unbound to its def' }
}

It 'the driver this job names is a JobDriver the game can build' {
    # An abstract class, or one that is not a JobDriver, is a def that loads and a job that
    # throws the first time a pawn takes it.
    if (-not $driverClassName) { 'the job names no driverClass'; return }
    $t = $byName[$driverClassName]
    if (-not $t) { "no class named $driverClassName"; return }
    if (-not $byName['JobDriver'].IsAssignableFrom($t)) { "$driverClassName is not a JobDriver"; return }
    $o = [Activator]::CreateInstance($t)
    if ($null -eq $o) { "$driverClassName could not be instantiated" }
}

It 'the driver really does cast what it sits at to a Building, and this is one' {
    # Read off the compiled game: get_Building is ldarg.0, call get_TargetThingA, castclass,
    # ret. The castclass is why an anima tree cannot be wired up this way - it is a Plant, and
    # the cast throws the moment a pawn sits down. It is also the whole reason this mod ships no
    # assembly, so it is worth reading rather than asserting.
    $t = $byName[$driverClassName]
    if (-not $t) { "no class named $driverClassName"; return }
    $prop = $t.GetProperty('Building', [System.Reflection.BindingFlags]'Public,NonPublic,Instance')
    if (-not $prop) { "$driverClassName exposes no Building any more"; return }
    $il = $prop.GetGetMethod($true).GetMethodBody().GetILAsByteArray()
    $castTo = $null
    for ($i = 0; $i -lt $il.Length - 4; $i++) {
        if ($il[$i] -ne 0x74) { continue }   # castclass
        $castTo = $t.Module.ResolveType([BitConverter]::ToInt32($il, $i + 1))
        break
    }
    if (-not $castTo) { 'its Building accessor no longer casts anything'; return }

    # What this def will be instantiated as, resolved through the vanilla parent templates.
    $className = Get-Text $ballNode 'thingClass'
    $parent    = $ballNode.GetAttribute('ParentName')
    $hops = 0
    while (-not $className -and $parent -and $hops -lt 12) {
        $found = $null
        foreach ($dir in (Get-ChildItem $GameData -Directory)) {
            $p = Join-Path $dir.FullName 'Defs\ThingDefs_Buildings'
            if (-not (Test-Path $p)) { continue }
            foreach ($f in Get-ChildItem $p -Recurse -Filter *.xml) {
                $x = New-Object System.Xml.XmlDocument
                try { $x.Load($f.FullName) } catch { continue }
                $node = $x.DocumentElement.SelectSingleNode("ThingDef[@Name='$parent']")
                if ($node) { $found = $node; break }
            }
            if ($found) { break }
        }
        if (-not $found) { break }
        $className = Get-Text $found 'thingClass'
        $parent    = $found.GetAttribute('ParentName')
        $hops++
    }
    if (-not $className) { 'this def resolves to no thingClass at all'; return }
    $mine = $byName[$className]
    if (-not $mine) { "no class named $className"; return }
    if (-not $castTo.IsAssignableFrom($mine)) {
        "the driver casts to $($castTo.Name) and this def loads as $className"
    }
}

# =============================================================================================
Section 'Every setting reaches code that reads it'
# =============================================================================================

It 'no setting in these defs is one the game stopped reading' {
    # The game keeps fields nothing reads any more - seven in 1.6, among them
    # ThingDef.pathfinderDangerous and GraphicData.name. They load without a murmur and do
    # nothing, which is the quietest way for a ported mod to be wrong. A field read only through
    # reflection would be a false positive here; this mod writes none.
    if ($written.Count -eq 0) { 'no field was resolved at all, which cannot be right'; return }
    foreach ($k in ($written.Values | Sort-Object -Unique)) {
        if ((Get-Readers $k).Count -eq 0) { "$k : nothing in the game reads it" }
    }
}

It 'every setting on the joy giver is read by the giver class this def names' {
    # The rule that matters, and the one that catches the silent fault: requireChair has exactly
    # one reader in the whole game, JoyGiver_InteractBuildingSitAdjacent. Name another giver and
    # the setting stays in the XML, stays unread, and pawns look for a chair that is not there.
    $t = $byName[$giverClassName]
    if (-not $t) { "no class named $giverClassName"; return }
    # The def class itself counts: giverClass is read by JoyGiverDef.Worker, which is how the
    # giver gets built in the first place.
    $family = Get-Ancestry $t
    $family['JoyGiverDef'] = $true
    $checked = 0
    foreach ($k in ($written.Values | Sort-Object -Unique)) {
        if ($k -notlike 'JoyGiverDef.*') { continue }          # fields inherited from Def are
        $rs = Get-Readers $k                                   # identity, not settings
        if ($rs.Count -eq 0) { continue }                      # the test above owns that case
        $checked++
        $inFamily = @($rs | Where-Object { $family.ContainsKey($_) })
        if ($inFamily.Count -eq 0) {
            "$k is read by $(Show-Readers $rs) - none of them $giverClassName or above it"
        }
    }
    if ($checked -eq 0) { 'not one setting of the giver was checked, which cannot be right' }
}

It 'the length of the gaze and the number who may share it are read by the driver' {
    # These two JobDef fields mean nothing on their own: they are the driver's to consult, and a
    # driver that does not read them leaves 4000 ticks and two participants as decoration.
    $t = $byName[$driverClassName]
    if (-not $t) { "no class named $driverClassName"; return }
    $family = Get-Ancestry $t
    foreach ($field in 'JobDef.joyDuration', 'JobDef.joyMaxParticipants') {
        $short = $field.Split('.')[1]
        if (-not (Get-Text $jobNode $short)) { "the job declares no $short"; continue }
        $rs = Get-Readers $field
        $inFamily = @($rs | Where-Object { $family.ContainsKey($_) })
        if ($inFamily.Count -eq 0) { "$field is not read by $driverClassName or anything above it" }
    }
}

# =============================================================================================
Section 'What makes an eleventh type worth having'
# =============================================================================================

It 'the joy a pawn gains is credited under the job''s own joyKind' {
    # JoyUtility.JoyTickCheckEnd is the method that pays out. It reads the joyKind from the job,
    # so the type this mod adds is credited only because its JobDef names it.
    if (-not (Get-Text $jobNode 'joyKind')) { 'the job declares no joyKind'; return }
    $rs = Get-Readers 'JobDef.joyKind'
    if ($rs -notcontains 'JoyUtility') { "JobDef.joyKind is read by $($rs -join ', '), no JoyUtility among them" }
}

It 'the tally of recreation available on the map reads the building''s joyKind and the kind''s needsThing' {
    # This is why an eleventh type is worth more than a tenth piece of furniture. The tally that
    # expectations are measured against is built from buildings' joyKind, and a kind is only
    # counted as needing an object when needsThing is left true - which is why the mod does not
    # write it.
    if (-not (Get-Text $ballNode 'building/joyKind')) { 'the building declares no joyKind'; return }
    foreach ($pair in @(@('BuildingProperties.joyKind', 'JoyUtility'), @('JoyKindDef.needsThing', 'JoyUtility'))) {
        $rs = Get-Readers $pair[0]
        if ($rs -notcontains $pair[1]) { "$($pair[0]) is read by $($rs -join ', '), no $($pair[1]) among them" }
    }
}

# =============================================================================================
Section 'The numbers, against the vanilla defs on the same classes'
# =============================================================================================

It 'the gaze lasts what vanilla''s jobs on this driver last' {
    $mine = Get-Text $jobNode 'joyDuration'
    if (-not $mine) { 'the job declares no joyDuration'; return }
    $cousins = @($vanillaJobs.GetEnumerator() | Where-Object { $_.Value.Driver -eq $driverClassName -and $_.Value.Duration })
    if ($cousins.Count -eq 0) { "no vanilla job runs on $driverClassName, so there is nothing to compare with"; return }
    $values = @($cousins | ForEach-Object { [int]$_.Value.Duration } | Sort-Object -Unique)
    if ([int]$mine -lt $values[0] -or [int]$mine -gt $values[-1]) {
        "$mine ticks, where $($cousins.Count) vanilla job(s) on this driver use $($values -join ', ')"
    }
}

It 'no more may share the ball than share vanilla''s buildings on this driver' {
    $mine = Get-Text $jobNode 'joyMaxParticipants'
    if (-not $mine) { 'the job declares no joyMaxParticipants'; return }
    $cousins = @($vanillaJobs.GetEnumerator() | Where-Object { $_.Value.Driver -eq $driverClassName -and $_.Value.Participants })
    if ($cousins.Count -eq 0) { "no vanilla job on $driverClassName sets it, so there is nothing to compare with"; return }
    $values = @($cousins | ForEach-Object { [int]$_.Value.Participants } | Sort-Object -Unique)
    if ([int]$mine -lt $values[0] -or [int]$mine -gt $values[-1]) {
        "$mine, where the vanilla jobs on this driver use $($values -join ', ')"
    }
}

It 'the ball is picked about as often as vanilla''s buildings on this giver' {
    $mine = Get-Text $giverNode 'baseChance'
    if (-not $mine) { 'the giver declares no baseChance'; return }
    $cousins = @($vanillaGivers.GetEnumerator() | Where-Object { $_.Value.Giver -eq $giverClassName -and $_.Value.Chance })
    if ($cousins.Count -eq 0) { "no vanilla giver uses $giverClassName, so there is nothing to compare with"; return }
    $values = @($cousins | ForEach-Object { [double]$_.Value.Chance } | Sort-Object -Unique)
    if ([double]$mine -lt $values[0] -or [double]$mine -gt $values[-1]) {
        "$mine, where the vanilla givers on this class use $($values -join ', ')"
    }
}

# =============================================================================================

Write-Output ''
if ($script:failed -eq 0) { Write-Output "$($script:ran) tests, all passing." }
else                      { Write-Output "$($script:ran) tests, $($script:failed) failing." }

[System.AppDomain]::CurrentDomain.remove_AssemblyResolve($script:asmResolver)
exit ([int]($script:failed -gt 0))
