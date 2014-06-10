#!/bin/bash

. setEnvironment.sh

DEST="media@media-laptop"

  scp /etc/hosts $DEST:/tmp
  ssh $DEST "sudo cat /tmp/hosts > /etc/hosts"
