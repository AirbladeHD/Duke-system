git clone -n #link to repo /root/server-data/resources/temp
cd /root/server-data/resources/temp
git checkout HEAD backups
cd /root/server-data/resources/temp/backups/latest
backup=$(ls)
FILE=/root/server-data/resources/[system]/duke_manager/backups
if [ -d "$FILE" ]; then
    mv $backup /root/server-data/resources/[system]/duke_manager/backups/backup.sql
else
    mkdir /root/server-data/resources/[system]/duke_manager/backups
    mv $backup /root/server-data/resources/[system]/duke_manager/backups/backup.sql
fi
cd /root/server-data/resources
rm -r temp
