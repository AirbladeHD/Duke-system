###fxmanifest.lua

Die Datei "fxmanifest.lua" ist ein wichtiger Bestandteil jeder FiveM-Ressource, da sie Informationen über die Ressource bereitstellt und dem Server mitteilt, wie die Ressource geladen und verwendet werden soll.

- version: Gibt die Versionsnummer der Ressource an. In diesem Fall ist es "1.0.0".

- author: Hier wird der Autor der Ressource genannt, in diesem Fall "Cfx.re root@cfx.re".

- description: Eine kurze Beschreibung der Ressource, die erklärt, was sie macht. In diesem Fall handelt es sich um das Handling des Spawnens eines Spielers auf eine einheitliche Weise, um zu verhindern, dass Ressourcen eigene Spawn-Logik implementieren müssen.

- repository: Enthält den Link zum GitHub-Repository der Ressource.

- client_script 'spawnmanager.lua': Diese Zeile sagt dem Server, dass das Skript "spawnmanager.lua" auf der Client-Seite geladen werden soll, um das Spawnen der Spieler zu behandeln.

- fx_version: Gibt die verwendete FiveM Resource Manifest-Version an. In diesem Fall ist es "adamant".

- games { 'rdr3', 'gta5' }: Gibt an, für welche Spiele diese Ressource kompatibel ist. Hier ist die Ressource sowohl für RedM ("rdr3") als auch für GTA 5 ("gta5") ausgelegt.

- rdr3_warning: Eine Warnung, dass diese Ressource eine Vorabversion für RedM ist und möglicherweise inkompatibel wird, sobald RedM offiziell veröffentlicht wird.

###spawnmanager.lua

Die Datei "spawnmanager.lua" enthält den eigentlichen Code, der das Spawning der Spieler behandelt. Hier ist eine detaillierte Erläuterung der wichtigsten Teile des Skripts:

- Config: Dies ist eine Lua-Tabelle, die die Konfiguration der Fahrzeugkategorien und ihrer Eigenschaften enthält. Jede Kategorie hat eine Liste von Fahrzeugen, die durch Namen, Marken, Preise, Gesundheitswerte, Turbostärken, Traktionen, Handhabungen und mögliche Modifikationen definiert sind.

- loadSpawns(spawnString): Eine Funktion, die eine Reihe von Spawnpunkten aus einem JSON-String lädt und der Ressource hinzufügt.

- addSpawnPoint(spawn): Eine Funktion, die einen neuen Spawnpunkt zur Liste der verfügbaren Spawnpunkte hinzufügt.

- removeSpawnPoint(spawn): Eine Funktion, die einen vorhandenen Spawnpunkt aus der Liste der verfügbaren Spawnpunkte entfernt.

- setAutoSpawn(enabled): Eine Funktion, die die automatische Spawning-Option für den Spieler aktiviert oder deaktiviert.

- setAutoSpawnCallback(cb): Eine Funktion, die eine Callback-Funktion setzt, die aufgerufen wird, wenn ein automatisches Spawning stattfindet.

- forceRespawn(): Eine Funktion, die das erzwungene Respawnen eines Spielers ermöglicht.

- spawnPlayer(spawnIdx, cb): Eine Funktion, die den Spieler an einem bestimmten Spawnpunkt spawnen lässt. Wenn kein Spawnpunkt angegeben ist, wird ein zufälliger Spawnpunkt ausgewählt. Es berücksichtigt auch das Modell des Spielers und lädt die erforderlichen Modelle.

- Der Rest des Skripts enthält eine Schleife, die den Spielerstatus überwacht und den Spawning-Vorgang entsprechend steuert.

Das Skript ermöglicht es den Spielern, an bestimmten Spawnpunkten zu spawnen, und bietet auch die Möglichkeit, automatisch zu spawnen, wenn ein Spieler stirbt oder sich einloggt. Es enthält auch Funktionen zum Laden und Entfernen von Spawnpunkten sowie zur Konfiguration von Spielermodellen und -attributen.
