param(
    # Service name
    [Parameter(Mandatory = $True)]
    [string]
    $Name,
    
    # Service DLL Path
    [Parameter(Mandatory = $True)]
    [string]
    $Path,
    
    # Service Description
    [Parameter(Mandatory = $False)]
    [string]
    $Description = "A .NET Application running as a Linux Daemon."
)

# Register a dotnet application as a service under a provided name, 
function Register-DotnetDaemon {
    Write-Host "Registering service '$Name'..." -ForegroundColor Cyan;
    $config = Get-DotNetDaemonConfig;
    Set-Content -Value $config -Path "/etc/systemd/system/$($Name).service";
}

# Retrieve the location of the .NET Core runtime.
function Get-DotNetLocation {
    try {
        return (Get-Command -Name "dotnet" -ErrorAction Stop).Source;
    }
    catch {
        Write-Host ".NET Core (dotnet) is not installed on this host. Please install the 2.1 Runtime and restart the script." -ForegroundColor Red;
        exit;
    }
}

# Create a service config for the .NET Program
function Get-DotNetDaemonConfig {
    $execStart = Get-DotnetLocation + $Path;
    return "[Unit]
Description=$Description
DefaultDependencies=no

[Service]
Type=simple
ExecStart=$execStart
PIDFile=/tmp/$Name.pid

[Install]";
}

Register-DotnetDaemon;
