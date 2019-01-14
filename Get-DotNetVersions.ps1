function Get-DotNetVersions() {

    <#
        .SYNOPSIS
            An function to display installed versions of the .Net libraries.
        .EXAMPLE
            $DotNet = Get-DotNetVersions -Delimiter "_"
    #>

    param (
        # Feel Free to specify your delimeter of choice.
        [string]$Delimiter = "|"
        )

    # Compiling legacy .Net registry folders.
    $DotNetData = get-childitem "HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP"
    $NetOut = $null
    
    foreach ($item in $DotNetData) {
        $StringOut = $item.ToString()
        $Chunks = $StringOut.split('\')
        $NetOut = $NetOut + $Delimiter + $Chunks[-1]
    }

    # Collecting .Net 4+ Version information.
    $DotNet4Data = Get-ItemPropertyValue "HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full\" -Name "Release"

    # Switch to lookup version numbers and report back .Net version.
    switch ($DotNet4Data) {
        378389 {$NetOut = $NetOut + $Delimiter + ".NET Framework 4.5"}
        378675 {$NetOut = $NetOut + $Delimiter + ".NET Framework 4.5.1 installed with Windows 8.1 or Windows Server 2012 R2"}
        378758 {$NetOut = $NetOut + $Delimiter + ".NET Framework 4.5.1 installed on Windows 8, Windows 7 SP1, or Windows Vista SP2"}
        379893 {$NetOut = $NetOut + $Delimiter + ".NET Framework 4.5.2"}
        393295 {$NetOut = $NetOut + $Delimiter + ".NET Framework 4.6"}
        393297 {$NetOut = $NetOut + $Delimiter + ".NET Framework 4.6"}
        394254 {$NetOut = $NetOut + $Delimiter + ".NET Framework 4.6.1"}
        394271 {$NetOut = $NetOut + $Delimiter + ".NET Framework 4.6.1"}
        394802 {$NetOut = $NetOut + $Delimiter + ".NET Framework 4.6.2"}
        394806 {$NetOut = $NetOut + $Delimiter + ".NET Framework 4.6.2"}
        460798 {$NetOut = $NetOut + $Delimiter + ".NET Framework 4.7"}
        460805 {$NetOut = $NetOut + $Delimiter + ".NET Framework 4.7"}
        461308 {$NetOut = $NetOut + $Delimiter + ".NET Framework 4.7.1"}
        461310 {$NetOut = $NetOut + $Delimiter + ".NET Framework 4.7.1"}
        461808 {$NetOut = $NetOut + $Delimiter + ".NET Framework 4.7.2"}
        461814 {$NetOut = $NetOut + $Delimiter + ".NET Framework 4.7.2" }
        default { if ($DotNet4Data -gt 461814) {$NetOut = $NetOut + $Delimiter + "> .NET Framework 4.7.2"}}
    }

    # Filtering output, discarding unneeded data.
    $NetOut = $NetOut.replace("|CDF","")

    Return $NetOut.Substring(1)
}
