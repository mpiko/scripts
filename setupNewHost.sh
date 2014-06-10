#!/bin/bash

NEWHOST=dummy@pi

cd $HOME

# set up ssh autologin (prompts for password)
setupSSHinto $NEWHOST

# set up the bin utils
# tar zcvf /tmp/bin.tgz bin
# scp /tmp/bin.tgz $NEWHOST:/tmp
# ssh $NEWHOST "tar zxf /tmp/bin.tgz"
ssh $NEWHOST "[ -d localbin ] || mkdir -p localbin"
ssh $NEWHOST "git clone git://github.com/mpiko/scripts.git"
ssh $NEWHOST "mv scripts bin"
scp bin/.secrets $NEWHOST:bin/
 
# set up executable path to include the new bin dir.
ssh $NEWHOST "echo \"PATH=\\\$PATH:\\\$HOME/localbin\" >> .profile"

