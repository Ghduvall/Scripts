#!/bin/bash

check_process() {
  echo "$ts: checking $1"
  [ "$1" = "" ]  && return 0
  [ `pgrep -n $1` ] && return 1 || return 0
}


while [ 1 ]; do 
  # timestamp
  ts=`date +%T`

  echo "$ts: begin checking..."
  check_process "htop"
  #[ $? -eq 1 ] && echo "$ts: IT is running. Continuing check..."
    if [ $? -eq 0 ]; then
        echo "$ts: not running, restarting..." && `dropbox start -i > /dev/null`
        sleep 5
    else
        save_world=$(echo | save-all)
        stop_server=$(echo | stop)
        
        echo "it is running"
        screen -X exec $save_world
        screen -X exec $stop_server

        sleep 5
    fi
done
