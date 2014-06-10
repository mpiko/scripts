#!/bin/bash

nmap -sn 192.168.0.0/24 | grep report | sed 's/Nmap scan report for //'
nmap -sn 192.168.1.0/24 | grep report | sed 's/Nmap scan report for //'
