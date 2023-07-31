## Zusammenfassung der SQL-Datei `backup.sql`

Die SQL-Datei `backup.sql` enthält die Struktur und Daten von zwei Tabellen: `items` und `users`. Diese Tabellen sind Teil des Duke GTA 5 RP Servers und enthalten wichtige Informationen über Gegenstände und Benutzer im Spiel.

### Tabelle `items`

Die Tabelle `items` hat folgende Spalten:

- `name`: Der Name des Gegenstands (varchar, max. 100 Zeichen).
- `description`: Eine Beschreibung des Gegenstands (varchar, max. 500 Zeichen).
- `handler`: Ein Handler für den Gegenstand (longtext) - Funktion, das mit dem Gegenstand interagiert.
- `id`: Ein eindeutiger numerischer Wert für den Gegenstand (int, automatisch inkrementiert).

Diese Tabelle wird verwendet, um Informationen über verschiedene Gegenstände im Spiel zu speichern. Es ist anzumerken, dass in der vorliegenden Sicherungskopie nur ein Testeintrag mit den Werten 'Test' und 'Test' für `name` und `description` vorhanden ist.

### Tabelle `users`

Die Tabelle `users` enthält folgende Spalten:

- `username`: Der Benutzername (varchar, max. 50 Zeichen) des Spielers.
- `license`: Die Lizenz (varchar, max. 255 Zeichen) des Spielers.
- `balance`: Der Kontostand (int) des Spielers im Spiel.
- `money`: Die Bargeldmenge (int) des Spielers im Spiel.
- `inventory`: Das Inventar (varchar, max. 255 Zeichen) des Spielers als JSON-String.
- `entry`: Ein boolischer Wert (tinyint), der angibt, ob der Spieler eingeloggt ist (1) oder nicht (0).
- `permgroup`: Ein boolischer Wert (tinyint), der die Berechtigungsgruppe des Spielers angibt (1 = vorhanden, 0 = nicht vorhanden).
- `coords`: Die Koordinaten (varchar, max. 100 Zeichen) des Spielers im Spiel.
- `style`: Die äußere Erscheinung (Skin) (varchar, max. 255 Zeichen) des Spielers.
- `job`: Der Beruf (varchar, max. 50 Zeichen) des Spielers.
- `id`: Ein eindeutiger numerischer Wert für den Spieler (int, automatisch inkrementiert).

Diese Tabelle speichert wichtige Spielerdaten, darunter Benutzerinformationen, Spielwährung, Inventar, Standort und Beruf.

**Hinweis:** Die vorliegende SQL-Datei enthält nur Beispieldaten, die für Tests und die Entwicklung des Duke GTA 5 RP Servers verwendet wurden. In einer produktiven Umgebung würden diese Tabellen wahrscheinlich viele weitere Datensätze enthalten, die von den Spielern generiert wurden.
