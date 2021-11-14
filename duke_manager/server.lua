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
print("Installiere benötigte Pakete...")
os.execute("apt install ca-certificates apt-transport-https lsb-release gnupg curl nano unzip -y")
os.execute("apt update && apt upgrade -y")
if(os.capture("whereis php8.0") == "php8:") then
  print("PHP 8 ist nicht installiert")
  print("Installiere PHP 8...")
  os.execute("chmod +x /root/server-data/resources/[system]/duke_manager/installer.sh")
  os.execute("cd /root/server-data/resources/[system]/duke_manager")
  print(os.capture("./installer.sh"))
  --os.execute("cd")
  --print("Füge Paketquellen hinzu...")
  --print(os.capture("wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add -"))
  --print(os.capture('echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list'))
  --os.execute("wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add -")
  --os.execute('echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list')
  --print("Paketquellen hinzugefügt")
  --os.execute("apt update && apt upgrade -y")
  --print("Paketlisten aktualisiert")
  --print("Starte PHP 8 Installation...")
  --print(os.capture("apt install php8.0 php8.0-cli php8.0-common php8.0-curl php8.0-gd php8.0-intl php8.0-mbstring php8.0-mysql php8.0-opcache php8.0-readline php8.0-xml php8.0-xsl php8.0-zip php8.0-bz2 libapache2-mod-php8.0 -y"))
  print("PHP 8 wurde installiert")
else
  print("PHP 8 wurde gefunden")
end
if os.capture("whereis apache2") == "apache2:" then
  print("Apache2 Webserver ist nicht installiert")
  print("Installiere Apache2 Webserver...")
  os.execute("apt update && apt upgrade -y")
  print("Starte Apache2 Webserver Installation...")
  os.execute("apt install apache2 -y")
  print("Apache2 Webserver wurde installiert")
else
  print("Apache2 Webserver wurde gefunden")
end
if os.capture("dpkg -s mariadb-server") == "" then
  print("MariaDB Server ist nicht installiert")
  print("Installiere MariaDB Server...")
  os.execute("apt install mariadb-server mariadb-client -y")
  os.execute("mysql -e 'UPDATE mysql.user SET Password = PASSWORD('duke2021') WHERE User = 'root''")
  os.execute("mysql -e 'DROP USER ''@'$(hostname)''")
  os.execute('mysql -e "FLUSH PRIVILEGES"')
  print("MariaDB Server wurde installiert")
else
  print(os.capture("dpkg -s mariadb-server"))
end
if os.capture("whereis phpmyadmin") == "phpmyadmin:" then
  print("phpMyAdmin wurde nicht gefunden")
  print("Installiere phpMyAdmin...")
  os.execute("cd /usr/share")
  os.execute("wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.zip -O phpmyadmin.zip")
  os.execute("unzip phpmyadmin.zip")
  os.execute("rm phpmyadmin.zip")
  os.execute("mv phpMyAdmin-*-all-languages phpmyadmin")
  os.execute("chmod -R 0755 phpmyadmin")
  os.execute("cp /root/server-data/resources/[system]/duke_manager/phpmyadmin.conf /etc/apache2/conf-available/")
  os.execute("a2enconf phpmyadmin")
  os.execute("systemctl reload apache2")
  os.execute("mkdir /usr/share/phpmyadmin/tmp/")
  os.execute("chown -R www-data:www-data /usr/share/phpmyadmin/tmp/")
  print("phpMyAdmin wurde installiert")
else
  print("phpMyAdmin wurde gefunden")
end
print("Datenbankkonfiguration wird geladen...")
os.execute('mysql -u dukecity < /root/server-data/resources/[Dev]/duke_manager/duke.sql')
print("Datenbankkonfiguration geladen")
if os.capture('dpkg -s git-all') == "" then
    print("Git wird installiert...")
    os.execute('apt install git-all -y')
    print("Git wurde installiert")
end
if os.capture('ls resources/[duke_scripts]') == "" then
    print("Git Archiv wurde nicht gefunden")
    print("Git Archiv wird geklont...")
    os.execute("ssh-keyscan -t rsa -H github.com >> ~/.ssh/known_hosts")
    os.execute('git clone git@github.com:AirbladeHD/Duke-scripts.git /root/server-data/resources/[duke_scripts]')
    print("Git Archiv wurde geklont")
else
    print("Git Archiv wurde gefunden")
end
if Config.settings['autoUpdate'] == false then
    print("Automatisches Updaten ist ausgeschaltet")
else
    print("Automatisches Updaten ist eingeschaltet")
    print("Git Archiv wird geupdated...")
    os.execute("cd resources/[duke_scripts] && git pull origin main")
    print("Git Archiv wurde geupdated")
end
--print(os.capture('dpkg -s git-all'))
--os.execute('apt install git-all')
print("Ressourcen werden gestartet...")
for i = 1, #Config.resources, 1 do
    StartResource(Config.resources[i])
    print("Resource "..Config.resources[i].." aus Config geladen")
end
print("Ressourcen wurden gestartet")
print("|---------------------------------------------------------------|")
print("| Duke City Script Paket Installation erfolgreich abgeschlossen |")
print("|---------------------------------------------------------------|")