#!/bin/bash

if [ "$SSH_CLIENT" ]
then
  alias vi=vim
else
  alias vi='gvim $@ 2>/dev/null'
fi
