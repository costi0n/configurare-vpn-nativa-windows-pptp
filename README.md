# Script di Configurazione VPN

Questo script PowerShell è progettato per configurare una connessione VPN su un sistema Windows. È utile per automatizzare la configurazione di una VPN, la creazione di uno script batch per la connessione e la generazione di uno shortcut per l'esecuzione facilitata.

## Caratteristiche

- Configura una connessione VPN PPTP con credenziali e indirizzo server definiti.
- Genera uno script batch (`connect-vpn.bat`) per stabilire la connessione VPN.
- Crea uno shortcut (`connect-vpn.lnk`) per avviare lo script batch con privilegi elevati.

## Prerequisiti

- Windows PowerShell
- Privilegi di amministratore sulla macchina su cui viene eseguito lo script

## Configurazione

Modificare le variabili iniziali dello script per adattarle alle proprie necessità:

- `$vpnServerIP`: Indirizzo IP del server VPN
- `$vpnName`: Nome della connessione VPN
- `$vpnUsername`: Nome utente per la VPN
- `$vpnPassword`: Password per la VPN
- `$ipAddresses`: Elenco degli indirizzi IP da raggiungere attraverso il gateway VPN

## Uso

1. Eseguire lo script in PowerShell con privilegi di amministratore.
2. Lo script configurerà automaticamente la connessione VPN e genererà lo script batch e lo shortcut necessari.
3. Utilizzare lo shortcut `connect-vpn.lnk` per connettersi alla VPN configurata.

## Note Importanti

- **Sicurezza**: Lo script include le credenziali in chiaro. Assicurarsi di gestire il file con adeguate misure di sicurezza.
- **Compatibilità**: Testato su Windows 10 e Windows Server 2016.