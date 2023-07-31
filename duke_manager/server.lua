function os.capture(cmd, raw)
    local f = assert(io.popen(cmd, 'r'))
    local s = assert(f:read('*a'))
    f:close()
    if raw then return s end
    s = string.gsub(s, '^%s+', '')
    s = string.gsub(s, '%s+$', '')
    s = string.gsub(s, '[\n\r]+', ' ')
    return s
end
print("DDDDDDDDDDDDD                          kkkkkkkk                                                                    1111111                000000000     ")
print("D::::::::::::DDD                       k::::::k                                                                   1::::::1              00:::::::::00   ")
print("D:::::::::::::::DD                     k::::::k                                                                  1:::::::1            00:::::::::::::00 ")
print("DDD:::::DDDDD:::::D                    k::::::k                                                                  111:::::1           0:::::::000:::::::0")
print("  D:::::D    D:::::D uuuuuu    uuuuuu   k:::::k    kkkkkkk eeeeeeeeeeee         vvvvvvv           vvvvvvv           1::::1           0::::::0   0::::::0")
print("  D:::::D     D:::::Du::::u    u::::u   k:::::k   k:::::kee::::::::::::ee        v:::::v         v:::::v            1::::1           0:::::0     0:::::0")
print("  D:::::D     D:::::Du::::u    u::::u   k:::::k  k:::::ke::::::eeeee:::::ee       v:::::v       v:::::v             1::::1           0:::::0     0:::::0")
print("  D:::::D     D:::::Du::::u    u::::u   k:::::k k:::::ke::::::e     e:::::e        v:::::v     v:::::v              1::::l           0:::::0 000 0:::::0")
print("  D:::::D     D:::::Du::::u    u::::u   k::::::k:::::k e:::::::eeeee::::::e         v:::::v   v:::::v               1::::l           0:::::0 000 0:::::0")
print("  D:::::D     D:::::Du::::u    u::::u   k:::::::::::k  e:::::::::::::::::e           v:::::v v:::::v                1::::l           0:::::0     0:::::0")
print("  D:::::D     D:::::Du::::u    u::::u   k:::::::::::k  e::::::eeeeeeeeeee             v:::::v:::::v                 1::::l           0:::::0     0:::::0")
print("  D:::::D    D:::::D u:::::uuuu:::::u   k::::::k:::::k e:::::::e                       v:::::::::v                  1::::l           0::::::0   0::::::0")
print("DDD:::::DDDDD:::::D  u:::::::::::::::uuk::::::k k:::::ke::::::::e                       v:::::::v                111::::::111        0:::::::000:::::::0")
print("D:::::::::::::::DD    u:::::::::::::::uk::::::k  k:::::ke::::::::eeeeeeee                v:::::v          ...... 1::::::::::1 ......  00:::::::::::::00 ")
print("D::::::::::::DDD       uu::::::::uu:::uk::::::k   k:::::kee:::::::::::::e                 v:::v           .::::. 1::::::::::1 .::::.    00:::::::::00   ")
print("DDDDDDDDDDDDD            uuuuuuuu  uuuukkkkkkkk    kkkkkkk eeeeeeeeeeeeee                  vvv            ...... 111111111111 ......      000000000     ")
print("|--------------------------------------------------|")
print("| Duke City Script Paket wird jetzt installiert... |")
print("|--------------------------------------------------|")
if(os.capture("whereis php8.0") == "php8:") then
  print("PHP 8 ist nicht installiert")
else
  print("PHP 8 wurde gefunden")
end
if os.capture("whereis apache2") == "apache2:" then
  print("Apache2 Webserver ist nicht installiert")
else
  print("Apache2 Webserver wurde gefunden")
end
if os.capture("dpkg -s mariadb-server") == "" then
  print("MariaDB Server ist nicht installiert")
else
  print("MariaDB Server wurde gefunden")
end
if os.capture("whereis phpmyadmin") == "phpmyadmin:" then
  print("phpMyAdmin wurde nicht gefunden")
else
  print("phpMyAdmin wurde gefunden")
end
if Config.settings["createDatabase"] == true then
  print("Datenbankkonfiguration wird geladen...")
  if Config.settings["overwriteDatabase"] == true then
    print("Datenbanküberschreibung ist aktiviert")
    print("Lade letztes Backup...")
    os.execute('chmod +x /root/server-data/resources/[system]/duke_manager/pullBackup.sh')
    os.execute("/root/server-data/resources/[system]/duke_manager/pullBackup.sh")
    os.execute('mysql --password= --user= < /root/server-data/resources/[system]/duke_manager/backups/backup.sql')
  else
    os.execute('mysql --password= --user= < /root/server-data/resources/[system]/duke_manager/duke.sql')
  end
print("Datenbankkonfiguration geladen")
end
if os.capture('dpkg -s git-all') == "" then
  print("Git ist nicht installiert")
else
  print("Git wurde gefunden")
end
if os.capture('ls resources/[duke_scripts]') == "" then
    print("Git Archiv wurde nicht gefunden")
    print("Git Archiv wird geklont...")
    os.execute('git clone https://@github.com/AirbladeHD/Duke-scripts.git /root/server-data/resources/[duke_scripts]')
    print("Git Archiv wurde geklont")
else
    print("Git Archiv wurde gefunden")
end
if Config.settings['autoUpdate'] == false then
    print("Automatisches Updaten ist ausgeschaltet")
else
    print("Automatisches Updaten ist eingeschaltet")
    print("Git Archiv wird geupdated...")
    os.execute("cd /root/server-data/resources/[duke_scripts] && git stash push --include-untracked && git stash drop")
    os.execute("git fetch && git pull origin main")
    print("Git Archiv wurde geupdated")
end
print("Ressourcen werden gestartet...")
for i = 1, #Config.resources, 1 do
    StartResource(Config.resources[i])
    print("Resource "..Config.resources[i].." aus Config geladen")
end
print("Ressourcen wurden gestartet")
print("|---------------------------------------------------------------|")
print("| Duke City Script Paket Installation erfolgreich abgeschlossen |")
print("|---------------------------------------------------------------|")
