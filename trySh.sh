#!/bin/bash

. setEnvironment.sh

NEWHOST="pi@rpi"

ssh $NEWHOST "echo \"PATH=\\\$PATH:\\\$HOME/bin:\\\$HOME/localbin\" >> .profile"
