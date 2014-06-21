#!/bin/bash

nmap -sn 10.1.1.0/24 | grep report | sed 's/Nmap scan report for //'
