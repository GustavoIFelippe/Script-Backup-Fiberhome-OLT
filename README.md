# Script-Backup-Fiberhome-OLT
Fiberhome OLT backup automation bash script, via crontab.   

- Fill devicesOLT archive with your OLT infos (IP|USER|PASS|ENPASS|HOSTNAME). Remember to left a blank line at the end of the archive.
- Replace variables values with your need in the file "backupOLT.sh".
- Create crontab line to execute automatically as you need. (Ex: 0 3 * * * /Fiberhome/OLT_Backup_Script/backupOLT.sh > /dev/null 2>&1)

Desirable: Create a script to clear the backup files directory based on how old they are, or how many files is in it.
