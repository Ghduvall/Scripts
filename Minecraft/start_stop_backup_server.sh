#!/bin/bash

backup_path='/home/mine-user/Server_Files/'
destination_path='/home/mine-user/backups/Server_Files'
log_path='/home/mine-user/Server_Files/logs/backup-logs.txt'
copy_var=$(cp -R $backup_path "$destination_path $(date +"%m-%d-%y-%r")")

# commands to save and stop the minecraft world
#save_world=$(echo | 'save-all')
#stop_server=$(echo | 'stop')

# timestamp
ts=`date +%T`

check_process() {
  echo "$ts: checking $1"
  [ "$1" = "" ]  && return 0
  [ `pgrep -n $1` ] && return 1 || return 0
}


save_stop_world() {
    echo "saving and stopping minecraft world now!"
    /home/mine-user/tools/mcrcon/./mcrcon -H 127.0.0.1 -P 25575 -p 306088 save-all
    sleep 5
    /home/mine-user/tools/mcrcon/./mcrcon -H 127.0.0.1 -P 25575 -p 306088 stop
    sleep 80
    #screen -X stuff "exit"$(echo -ne '\015')
    screen -X -S mysession quit
}

copy_server_files() {
    echo -e "Files are being copied"
    $copy_var
    sleep 20
}

write_log_files() {
    echo -e "\nI run now at $(date)" >> $log_path
    echo -e "These files have been backed up $backup_path to this destination $destination_path" >> $log_path
}

start_world() {
    sleep 10
    echo -e "Starting up minecraft world"
    screen -S mysession -d -m bash
    screen -X stuff "/home/mine-user/Server_Files/start_mineserver.sh"$(echo -ne '\015')
    #screen -X paste
}

echo "$ts: begin checking..."
check_process "java"

#[ $? -eq 1 ] && echo "$ts: IT is running. Continuing check..."
if [ $? -eq 0 ]; then
    echo "$ts: Server is not running."
    copy_server_files
    write_log_files
    #echo "$ts: not running. I'm doing nothing" && `dropbox start -i > /dev/null`
    #sleep 5
else
    #stop_server=$(echo | stop)

    echo "Server is running."
    save_stop_world
    copy_server_files
    write_log_files

fi


start_world