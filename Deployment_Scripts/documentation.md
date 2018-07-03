# For CTFd client nodes:

## modify_hosts.sh

To add or remove a line in /etc/hosts file to point a hostname to the IP address.

Example as DETERLab command for new client nodes:

```tb-set-node-startcmd $n0 "sudo /share/ctfd/modify_hosts.sh add 10.64.0.19 ctf.ncl.sg"```

# For CTFd server VM:

These scripts should be placed in the CTFd server VM. The working directory will be changed to the folder containing these scripts automatically when run.

## install_ctfd_prerequisites.sh

To install prerequisites for CTFd, including setting up uWSGI and nginx.

Must be run once.

```sudo ./install_ctfd_prerequisites.sh ```

## add_ctfd_instance.sh

To create and start a new CTFd instance.

```sudo ./add_ctfd_instance.sh <hostname> <ctfname> <admin's NCL email>```

- *hostname* can be any URL
- *ctfname* is the name shown on the CTF website banner
- *admin's NCL email* is the login email of the admin in ncl.sg

For example:

> sudo ./add_ctfd_instance.sh cs4238.ctf.ncl.sg "CS4238 CTF" john@doe.com

## remove_ctfd_instance.sh

To stop and remove an existing CTFd instance.

```sudo ./remove_ctfd_instance.sh <hostname>```