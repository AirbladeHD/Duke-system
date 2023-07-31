## Brute-Force-Angriff und eigener Hash-Algorithmus (GTA 5 RP Server)

Dieser Ordner enthält Python- und Lua-Skripte für einen Brute-Force-Angriff und die Implementierung meines eigenen Hash-Algorithmus, der für einen GTA 5 RP Server entwickelt wurde.

### Hintergrund:

Dieses Projekt entstand als Versuch, einen eigenen Hash-Algorithmus namens "Duke-Hash" für einen GTA 5 RP Server zu entwickeln. Der Duke-Hash sollte als alternative Methode zur Verarbeitung von Passwörtern und anderen sensiblen Informationen dienen.

### Dateien:

1. `bruteforce.py`: Führt einen Brute-Force-Angriff durch, um die Nonce zu finden, die den angegebenen Nonce-Hash unter Verwendung des Duke-Hash-Algorithmus erzeugt.

2. `hash.lua`: Enthält die Implementierung des Duke-Hash-Algorithmus zur Berechnung des Hashwerts eines Textes.

3. `luaTest.py`: Ein Testskript, das die Funktionen des Duke-Hash-Algorithmus mithilfe der Lupa-Bibliothek überprüft.

4. `ras.lua`: Enthält einfache Funktionen zur Schlüsselerzeugung und Verschlüsselung/Entschlüsselung mithilfe eines RSA-ähnlichen Algorithmus.

5. `srsa.lua`: Enthält Funktionen zur Erzeugung von Zufallszahlen, Überprüfung von Primzahlen und Erzeugung eines einfachen RSA-ähnlichen Schlüsselpaars.

### Verwendung:

1. Führen Sie `bruteforce.py` aus, um den Brute-Force-Angriff zu starten und die Nonce zu finden, die den angegebenen Nonce-Hash unter Verwendung des Duke-Hash-Algorithmus erzeugt.

2. Der selbst entwickelte Duke-Hash-Algorithmus ist in `hash.lua` implementiert und kann in Lua-Skripten verwendet werden.

3. Verwenden Sie `luaTest.py`, um die Lua-Funktionen des Duke-Hash-Algorithmus zu testen.

4. `ras.lua` enthält einfache RSA-ähnliche Funktionen zur Schlüsselerzeugung und Verschlüsselung/Entschlüsselung.

5. `srsa.lua` enthält Funktionen zur Erzeugung eines einfachen RSA-ähnlichen Schlüsselpaars.

Hinweis: Obwohl ich mein Bestes getan habe, um einen eigenen Hash-Algorithmus zu entwickeln, ist es wichtig zu betonen, dass die Sicherheitsalgorithmen in diesem Projekt nicht für den Einsatz in realen Sicherheitsanwendungen geeignet sind. Der Duke-Hash-Algorithmus wurde aufgrund meiner begrenzten Möglichkeiten nicht gründlich genug getestet und sollte nicht als Ersatz für etablierte kryptografische Verfahren verwendet werden.
