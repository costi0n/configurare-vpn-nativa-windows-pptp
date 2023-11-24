# Variabili di configurazione per la VPN
$vpnServerIP = "1.2.3.4"
$vpnName = "VPN_M2C"
$vpnUsername = "vpnUs3r"
$vpnPassword = "vpnPassw0rd"

# ip da raggiungere via gateway VPN
$ipAddresses = @("10.51.74.7", "10.51.74.9", "10.51.74.10")

# Percorso e nome del file batch e del file lnk
$batFilePath = "$PSScriptRoot\connect-vpn.bat"
$shortcutPath = "$PSScriptRoot\connect-vpn.lnk"

# Eliminazione dei file esistenti
if (Test-Path $batFilePath) { Remove-Item $batFilePath }
if (Test-Path $shortcutPath) { Remove-Item $shortcutPath }

# Creazione della connessione VPN
try {
    Add-VpnConnection -Name $vpnName -ServerAddress $vpnServerIP -TunnelType Pptp -EncryptionLevel Required -AuthenticationMethod MsChapv2 -SplitTunneling -RememberCredential -ErrorAction Stop
    Set-VpnConnection -Name $vpnName -SplitTunneling $True

    Write-Host "Connessione VPN PPTP $vpnName creata."
} catch {
    Write-Host "Errore nella creazione della connessione VPN: $vpnName"
    exit
}

# Template per lo script batch
$batContent = @"
@echo off
rasdial "$vpnName" $vpnUsername $vpnPassword

for /f "tokens=3 delims=: " %%a in ('netsh interface ip show address "$vpnName" ^| findstr "IP"') do set IP=%%a

"@

foreach ($ip in $ipAddresses) {
    $batContent += "route add $ip mask 255.255.255.255 %IP%`n"
}

$batContent += "pause"

# Scrittura dello script batch nel file
Set-Content -Path $batFilePath -Value $batContent

# Creazione dello shortcut
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut($shortcutPath)
$Shortcut.TargetPath = $batFilePath
$Shortcut.IconLocation = "imageres.dll,227" # Icona grafica di sistema
$Shortcut.Save()

# Impostazione di 'Esegui come amministratore' per lo shortcut
$bytes = [System.IO.File]::ReadAllBytes($shortcutPath)
$bytes[0x15] = $bytes[0x15] -bor 0x20  #  Imposta il byte 21 (0x15) bit 6 (0x20) su ON
[System.IO.File]::WriteAllBytes($shortcutPath, $bytes)

# Stampa di conferma
Write-Host "Shortcut per la connessione VPN creato e configurato per essere eseguito come amministratore."