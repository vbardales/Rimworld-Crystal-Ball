<#
.SYNOPSIS
  Crops the three Workshop pictures out of the Pickle captures of Tests/Pickle/Mod/Pickle/Features/05-workshop-captures.feature.
.DESCRIPTION
  The captures are 1920 x 1080 with the game's interface around the edges. At the closest zoom the ball is in the middle of
  the screen, so a centred crop leaves the interface out. The result goes to Art/WorkshopScreenshots/, named 01-, 02-, 03- in
  the order they go on the Steam page and holding nothing else: the folder is uploaded as it is (PUBLISHING.md, "Images").
  -Source is the folder of the run's screenshots; -Width and -Height are the size of the crop, centred on the middle of the screen.
#>
param(
    [Parameter(Mandatory)][string]$Source,
    [int]$Width = 960,
    [int]$Height = 540,
    [string]$Destination = (Join-Path $PSScriptRoot 'WorkshopScreenshots')
)
Add-Type -AssemblyName System.Drawing
$pictures = [ordered]@{
    '01-the-ball-by-day.png'      = 'workshop-1---the-ball-by-day'
    '02-the-ball-at-night.png'    = 'workshop-2---the-ball-at-night'
    '03-a-colonist-gazing.png'    = 'workshop-3---a-colonist-gazing'
}
New-Item -ItemType Directory -Force $Destination | Out-Null
foreach ($name in $pictures.Keys) {
    $file = Get-ChildItem -LiteralPath $Source -Filter '*.png' | Where-Object { $_.Name -like "*$($pictures[$name])*" } | Select-Object -First 1
    if (-not $file) { throw "no capture named like '$($pictures[$name])' in $Source" }
    $image = [System.Drawing.Image]::FromFile($file.FullName)
    try {
        $x = [int](($image.Width - $Width) / 2)
        $y = [int](($image.Height - $Height) / 2)
        $bitmap = New-Object System.Drawing.Bitmap $Width, $Height
        $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
        $graphics.DrawImage($image, (New-Object System.Drawing.Rectangle 0, 0, $Width, $Height), (New-Object System.Drawing.Rectangle $x, $y, $Width, $Height), [System.Drawing.GraphicsUnit]::Pixel)
        $graphics.Dispose()
        $target = Join-Path $Destination $name
        $bitmap.Save($target, [System.Drawing.Imaging.ImageFormat]::Png)
        $bitmap.Dispose()
        '{0}  {1} x {2}, {3:N0} bytes' -f $name, $Width, $Height, (Get-Item $target).Length
    }
    finally { $image.Dispose() }
}
