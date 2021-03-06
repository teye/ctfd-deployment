#!/usr/bin/env bash

# Arguments
server_ip="$1"
server_port="$2"
command="${@:3}"

printusage() {
  echo "sudo $0 <server_ip> <server_port> <command> [<command_args...>]"
}

if (( $# < 3 )); then
  echo "Failed: Wrong number of arguments."
  printusage
  exit
fi

if [ "$EUID" -ne 0 ]; then 
  echo "Failed: Please run as root."
  printusage
  exit
fi



echo "Sending the command: $command"
echo "$command" | nc $server_ip $server_port