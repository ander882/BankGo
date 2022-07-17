#!/bin/bash

# Local process variables.  Call this for each process.

taskString="05 Setup vars"
startTask "$taskString"


# Setup some vars
CONFIG[processDir]=${CONFIG[_HOME]}/process

CONFIG[dbDir]=${CONFIG[_HOME]}/db
CONFIG[dbBackupDir]=${CONFIG[_HOME]}/db/backup

CONFIG[_dbBackupDir]=${CONFIG[_HOME]}/db/backup


endTask "$taskString"
