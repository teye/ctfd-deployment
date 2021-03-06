#!/usr/bin/env bash

# Default IP address for host
server_ip="10.64.0.19"
server_port="8887"

# Arguments
hostname="$1"
ctf_name="$2"
admin_ncl_email="$3"
ncl_team_name="$4"

printusage() {
  echo "sudo $0 <hostname> <ctf_name> <admin_ncl_email> <ncl_team_name> [<plugin_names...>] [--install-root-ca]"
}

if (( $# < 4 )); then
  echo "Failed: Wrong number of arguments."
  printusage
  exit
fi

if [ "$EUID" -ne 0 ]; then 
  echo "Failed: Please run as root."
  printusage
  exit
fi



# Get the DIR of this file
DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi

# Get the last argument
for last in "$@"; do :; done

# Add hostname to /etc/hosts
source "$DIR/modify_hosts.sh" add "$server_ip" "$hostname"

# Install root CA if option is set in last argument
remove_last_arg=0
if [ "$last" == "--install-root-ca" ]; then 
  source "$DIR/install_root_ca.sh"
  remove_last_arg=1
fi

# Setup and start ctfd instance at server
source "$DIR/send_tcp_command.sh" "$server_ip" "$server_port" add "$hostname" \"$ctf_name\" "$admin_ncl_email" "$ncl_team_name"
for plugin_name in "${@:5:$(($#-remove_last_arg))}"
do
  source "$DIR/send_tcp_command.sh" "$server_ip" "$server_port" add-plugin "$hostname" "$plugin_name"
done
source "$DIR/send_tcp_command.sh" "$server_ip" "$server_port" start "$hostname"