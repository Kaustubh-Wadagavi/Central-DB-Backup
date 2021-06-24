#! /bin/bash

DB_USER=root
DB_PASS=Krish!@3agni

# Declared Database names 
declare -a DB_NAMES=(
                     "os_demo"
		     "os_nih"
		     "kmc_os"
		    )

# Declared Dump storing paths
declare -a DB_PATHS=(
                     "/home/krishagni/Desktop/demo_backup"
	             "/home/krishagni/Desktop/nih_backup"
                     "/home/krishagni/Desktop/kmc_database_backups"
		     )

# Declared the file names
declare -a DB_FILES=(
                     "DEMO_OPENSPECIMEN"
		     "NIH_OPENSPECIMEN"
		     "KMC_OPENSPECIMEN"
	            )

TakeBackup()
{
   for index in ${!DB_NAMES[*]}; do 
   echo ""
   echo "Tacking ${DB_FILES[$index]} DB Backup"
   mysqldump -u$DB_USER -p$DB_PASS --single-transaction --skip-lock-tables --routines "${DB_NAMES[$index]}" | gzip > ${DB_PATHS[$index]}/${DB_FILES[$index]}_`date +\%d-\%m-\%Y`.SQL.gz
   echo  "Deleting the older 30 day files of ${DB_FILES[$index]}"
   find ${DB_PATHS[$index]}/ -mtime +30 -exec rm {} \;
done
}
#Script Starts from here
TakeBackup

