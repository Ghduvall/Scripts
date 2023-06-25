#!/bin/bash


check_process() {
  echo "$ts: checking $1"
  [ "$1" = "" ]  && return 0
  [ `pgrep -n $1` ] && return 1 || return 0
}





backup_path='/home/mine-user/Server_Files/'
destination_path='/home/mine-user/backups/Server_Files'
log_path='/root/logs/backup-logs.txt'
copy_var=$(cp -R $backup_path "$destination_path $(date +"%m-%d-%y-%r")")

# Running cp command to copy all Server files with date stamp
$copy_var

echo -e "\nI run now at $(date)" >> $log_path
echo -e "These files have been backed up $backup_path to this destination $destination_path" >> $log_path