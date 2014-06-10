#!/bin/bash

. setEnvironment.sh

NEWHOST="pi@pi"

ssh $NEWHOST "echo \"PATH=\\\$PATH:\\\$HOME/bin:\\\$HOME/localbin\" >> .profile"
