#!/bin/bash

backup_destination_path='/home/mine-user/backups/*'


cleanup_backups() {
    find $backup_destination_path -type d -ctime +6 -exec rm -rf {} \;
}

cleanup_backups

