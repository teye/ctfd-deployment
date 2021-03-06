#!/usr/bin/env bash

# Variables
hostname="$1"
nclteamname="$2"
nclsio="http://172.18.178.45:8080"

printusage() {
  echo "Usage: sudo $0 <hostname> <ncl_team_name>"
}

echo "$0: Started..."

if [ "$#" -ne 2 ]; then
  echo "Failed: Wrong number of arguments."
  printusage
  exit
fi

if [ "$EUID" -ne 0 ]; then 
  echo "Failed: Please run as root."
  printusage
  exit
fi

# Set current working directory to script folder
cd "${0%/*}"

# Fail if this CTFd instance does not exist
if [ ! -d "$hostname" ]; then 
  echo "Failed: hostname does not exist."
  exit
fi



echo "Starting CTFd..."

# Start this CTFd instance with uWSGI
cd "$hostname"
uwsgi --plugin python -s /tmp/uwsgi_"$hostname".sock -w 'CTFd:create_app()' --chmod-socket=666 --pidfile /tmp/ctfd_"$hostname".pid --pyargv "--ncl-sio-url $nclsio --ncl-team-name $nclteamname" &>/dev/null &



echo "$0: Completed successfully!"
