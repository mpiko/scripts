#!/bin/bash

# Remember to change /etc/default/useradd
#   SHELL=/bin/bash
#
# -d = home in passwd
# -m = create home dir

USER=dummy
# create the user
sudo useradd $USER -d /home/$USER -m

# set the passwd
echo "pi
pi" | sudo passwd $USER

# to remove the user
# sudo userdel -r $USER
