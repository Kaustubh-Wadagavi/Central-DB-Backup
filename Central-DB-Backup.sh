#! /bin/bash

DB_USER=root
DB_PASS=Krish!@3agni

# Declared Database names 
declare -a DB_NAMES=(
                     "os_demo"
		     "os_nih"
		     "kmc_os"
		    )

takeBackup()
{
   for index in ${!DB_NAMES[*]} 
   do 
     echo ""
     echo "Tacking ${DB_NAMES[$index]} Backup"
     mysqldump -u$DB_USER -p$DB_PASS --single-transaction --skip-lock-tables --routines "${DB_NAMES[$index]}" | gzip > /home/krishagni/Desktop/Backups/${DB_NAMES[$index]}_`date +\%d-\%m-\%Y`.SQL.gz
   	
     echo  "Deleting 30 days older files from Backups"
     find /home/krishagni/Desktop/Backups/ -mtime +30 -exec rm {} \;

   done
}

#Script Starts from here
takeBackup
