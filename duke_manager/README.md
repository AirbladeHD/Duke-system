## Zusammenfassung des Duke City Script-Pakets

Das Duke City Script-Paket ist eine umfassende Sammlung von Lua-Skripten und Konfigurationsdateien für den Duke GTA 5 RP Server. Es bietet eine Vielzahl von Funktionen und Features, die dazu dienen, das Spielerlebnis zu verbessern, die Spielwelt zu verwalten und die Verwendung von Ressourcen zu optimieren. Nachfolgend sind die wichtigsten Komponenten und Funktionen des Pakets detailliert beschrieben:

### client.lua

Das `client.lua`-Skript ist für die Client-Seite des Spiels verantwortlich. Es enthält eine Endlosschleife, die mit `Citizen.CreateThread` erstellt wird und kontinuierlich ausgeführt wird. In dieser Schleife werden verschiedene Funktionen aufgerufen, um die Dichte von Fußgängern und Fahrzeugen in der Spielwelt zu beeinflussen:

- `SetPedDensityMultiplierThisFrame(0.0)`: Setzt die Dichte der Fußgänger in diesem Frame auf Null, wodurch keine zufällig generierten Fußgänger auftauchen.
- `SetScenarioPedDensityMultiplierThisFrame(0.0)`: Reduziert die Anzahl der Szenario-Fußgänger (NPCs, die bestimmte Aktivitäten ausführen, z. B. Essen, Telefonieren usw.).
- `SetRandomVehicleDensityMultiplierThisFrame(0.0)`: Verhindert das zufällige Erscheinen von Fahrzeugen auf der Straße.
- `SetParkedVehicleDensityMultiplierThisFrame(0.0)`: Verhindert das zufällige Erscheinen von geparkten Fahrzeugen am Straßenrand.
- `SetVehicleDensityMultiplierThisFrame(0.0)`: Setzt die Dichte der Fahrzeuge in diesem Frame auf Null, wodurch keine zufällig generierten Fahrzeuge auf der Karte erscheinen.

Diese Funktionen tragen dazu bei, die Ressourcenbelastung zu reduzieren und ein flüssigeres Spielerlebnis zu gewährleisten.

### config.lua

Die `config.lua`-Datei enthält verschiedene Einstellungen und Konfigurationen für das Duke City Script-Paket. Hier werden unter anderem zwei wichtige Abschnitte definiert:

1. `Config.resources`: Dies ist eine Liste von Ressourcen, die beim Starten des Servers geladen werden sollen. Es ermöglicht eine einfache Verwaltung und Aktualisierung von Skripten und Ressourcen.

2. `Config.settings`: In diesem Abschnitt können verschiedene Optionen für das Script-Paket festgelegt werden:
   - `autoUpdate`: Legt fest, ob die Skripte automatisch aktualisiert werden sollen (basierend auf einem Git-Archiv).
   - `overwriteDatabase`: Gibt an, ob die Datenbank überschrieben werden soll (wenn `true`, wird ein Backup wiederhergestellt).
   - `createDatabase`: Bestimmt, ob die Datenbanktabellen erstellt werden sollen, wenn sie nicht vorhanden sind.

Durch diese Konfigurationsoptionen kann das Script-Paket an die spezifischen Anforderungen und Präferenzen des Servers angepasst werden.

### duke.sql

Die `duke.sql`-Datei enthält das Grundgerüst der Datenbank für den Duke GTA 5 RP Server. Es werden hier verschiedene Tabellen definiert, um wichtige Spielerdaten, Gegenstände im Spiel, Apps, Anrufe, Kontakte und Fahrzeuge zu speichern. Einige der wichtigsten Tabellen sind:

- `users`: Diese Tabelle speichert die Benutzerdaten, wie Benutzername, Lizenz, Kontostand, Inventar und andere spielbezogene Informationen.

- `items`: In dieser Tabelle werden die Gegenstände im Spiel definiert, einschließlich ihres Namens, der Beschreibung und eines Handlers (falls vorhanden).

- `apps`: Hier werden Apps für das Ingame-Smartphone definiert. Es werden Informationen wie ID, Icon, HTML, JS, Client-Lua und Server-Lua für jede App gespeichert.

- `player_apps`: Diese Tabelle speichert die Zuordnung von Apps zu bestimmten Spielern.

- `calllist`: Hier werden Informationen zu Anrufen gespeichert, einschließlich der Anrufnummer, der Angerufenen Nummer, des Datums und der Lizenz des Anrufenden.

- `contacts`: Diese Tabelle enthält die Kontakte eines Spielers mit ihren Namen und Nummern.

- `vehicles`: Hier werden Informationen zu Fahrzeugen im Spiel gespeichert, wie Besitzer, Name, Hersteller, Kategorie, Konfiguration und Upgrades.

Die `duke.sql`-Datei bildet die Grundlage für die Datenbankverwaltung im Duke City Script-Paket und ermöglicht eine effiziente Speicherung und Verwaltung von Spielinformationen.

### fxmanifest.lua

Die `fxmanifest.lua`-Datei ist eine wichtige Konfigurationsdatei für das FiveM Resource Manifest. Sie enthält Informationen, die dem FiveM-Server mitteilen, welche Dateien und Skripte in der Ressource enthalten sind und wie sie geladen werden sollen. Im Fall des Duke City Script-Pakets enthält diese Datei:

- `fx_version 'bodacious'`: Gibt die FiveM Resource Manifest-Version an, mit der diese Ressource kompatibel ist.

- `game 'gta5'`: Gibt an, dass diese Ressource für das Spiel GTA 5 erstellt wurde.

- `client_script { 'client.lua' }`: Definiert, dass das Skript `client.lua` auf der Client-Seite des Spiels geladen werden soll.

- `server_scripts { 'config.lua', 'server.lua' }`: Definiert, dass die Skripte `config.lua` und `server.lua` auf der Server-Seite des Spiels geladen werden sollen.

### map.lua

Die `map.lua`-Datei enthält Informationen zur Platzierung und Generierung von Objekten in der Spielwelt. In diesem Fall enthält es:

- `vehicle_generator "airtug" { -54.26639938354492, -1679.548828125, 28.4414, heading = 228.2736053466797 }`: Definiert einen Punkt in der Spielwelt, an dem das Fahrzeug "airtug" generiert werden soll, mit den angegebenen Koordinaten und Ausrichtung (heading).

- `spawnpoint 'mp_m_freemode_01' { x = 402.9295, y = -996.5547, z = -99.00027 }`: Definiert einen Spawnpunkt für den Spieler mit dem Model "mp_m_freemode_01" (männlicher Charakter) und den angegebenen Koordinaten.

Diese Informationen werden verwendet, um bestimmte Objekte und Spawnpunkte in der Spielwelt zu definieren und zu steuern.

### pullBackup.sh

Das `pullBackup.sh`-Skript ist ein Shell-Skript, das verwendet wird, um Backups aus einem Git-Repository auf den Server zu ziehen. Hier sind die Schritte, die das Skript ausführt:

1. Es klont das Git-Repository in das Verzeichnis "/root/server-data/resources/temp".
2. Es wechselt in das Verzeichnis "/root/server-data/resources/temp".
3. Es wechselt zum Branch "backups" im Repository.
4. Es sucht nach dem neuesten Backup und speichert den Dateinamen in der Variablen `backup`.
5. Es überprüft, ob das Verzeichnis "/root/server-data/resources/[system]/duke_manager/backups" existiert. Wenn nicht, wird es erstellt.
6. Es verschiebt das neueste Backup in das Verzeichnis "/root/server-data/resources/[system]/duke_manager/backups/backup.sql".
7. Es kehrt zurück in das Verzeichnis "/root/server-data/resources".
8. Es löscht das temporäre Verzeichnis "/root/server-data/resources/temp".

Dieses Skript dient dazu, Backups aus dem Git-Repository auf den Server zu übertragen und zu verwalten, um die Integrität der Datenbank zu gewährleisten.

### server.lua

Das `server.lua`-Skript ist für die Server-Seite des Spiels verantwortlich. Es enthält eine Funktion `os.capture`, die verwendet wird, um Shell-Befehle auszuführen und deren Ausgabe zu erfassen. Das Skript enthält auch eine Reihe von Ausgaben, die den Status und die Ergebnisse verschiedener Systemüberprüfungen anzeigen, z. B. ob bestimmte Software wie PHP 8, Apache2, MariaDB Server, phpMyAdmin und Git auf dem Server installiert sind.

Das Skript enthält auch eine Reihe von Schritten, um die Installation und Konfiguration des Duke City Script-Pakets zu überprüfen. Es prüft, ob bestimmte Ressourcen (Git-Archiv) vorhanden sind, ob automatische Updates aktiviert sind, und es lädt alle in der `config.lua` definierten Ressourcen, um sicherzustellen, dass alles ordnungsgemäß gestartet wird.

Nach Abschluss der Überprüfungen und Ressourcenstarts gibt das Skript eine Abschlussmeldung aus, um anzuzeigen, dass die Installation des Duke City Script-Pakets erfolgreich abgeschlossen wurde.
