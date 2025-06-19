#!/bin/bash

# Raspberry Pi-specific configurations and utilities

# Check if we're on a Raspberry Pi using device tree model
if [ -f /proc/device-tree/model ] && grep -q "Raspberry Pi" /proc/device-tree/model; then
    # Temperature monitoring
    if [ -f /sys/class/thermal/thermal_zone0/temp ]; then
        alias get-rpi-temp='awk '\''{print "Temp:",$1/1000,"C"}'\'' /sys/class/thermal/thermal_zone0/temp'
        alias get-rpi-temp-f='awk '\''{print "Temp:",($1/1000)*9/5+32,"F"}'\'' /sys/class/thermal/thermal_zone0/temp'
    fi

    # Time synchronization for RPi
    if command -v ntpdate >/dev/null 2>&1; then
        alias set-rpi-time='sudo ntpdate -s && sudo hwclock --adjust && sudo hwclock --systohc'
    fi

    # CPU frequency monitoring
    if [ -f /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq ]; then
        alias get-rpi-cpu-freq='awk '\''{print "CPU Freq:",$1/1000,"MHz"}'\'' /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq'
    fi

    # Memory usage
    alias get-rpi-mem='free -h | grep -E "Mem|Swap"'

    # Disk usage
    alias get-rpi-disk='df -h /'

    # System load
    alias get-rpi-load='uptime'

    # GPIO utilities (if available)
    if command -v gpio >/dev/null 2>&1; then
        alias gpio-status='gpio readall'
    fi

    # Camera utilities (if available)
    if command -v raspistill >/dev/null 2>&1; then
        alias rpi-camera-test='raspistill -o test.jpg -t 1000'
    fi

    # vcgencmd utilities (Raspberry Pi specific)
    if command -v vcgencmd >/dev/null 2>&1; then
        alias rpi-cpu-temp='vcgencmd measure_temp'
        alias rpi-voltage='vcgencmd measure_volts'
        alias rpi-clock='vcgencmd measure_clock arm'
        alias rpi-memory='vcgencmd get_mem arm && vcgencmd get_mem gpu'
    fi
fi
