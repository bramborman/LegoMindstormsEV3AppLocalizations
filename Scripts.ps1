function New-EV3InstallLocationFile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Path
    )

    Out-File .ev3HomePath -InputObject $Path -Encoding UTF8 -NoNewLine
}

function Get-EV3InstallLocation {
    $location = Get-Content '.ev3HomePath' -Encoding UTF8
    return $location
}

function Install-Localization {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Localization
    )

    $installPath = Get-EV3InstallLocation

    if (!$installPath) {
        return
    }

    $sourcePath = Join-Path 'Localizations' (Join-Path $Localization 'Resources')
    Copy-Item $sourcePath $installPath -Recurse -Force
}

function Start-EV3App {
    $installPath = Get-EV3InstallLocation

    if (!$installPath) {
        return
    }

    $exePath = Join-Path $installPath 'MindstormsEV3.exe'
    Start-Process $exePath
}
