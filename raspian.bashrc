#!/bin/bash

alias set-rpi-time='sudo /usr/sbin/ntpdate -s; sudo /sbin/hwclock --adjust; sudo /sbin/hwclock --systohc'
alias get-rpi-temp='awk '\''{print "Temp:",$1/1000,"C"}'\'' /sys/class/thermal/thermal_zone0/temp'
