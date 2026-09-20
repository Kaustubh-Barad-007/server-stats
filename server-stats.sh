#!/bin/bash

echo "=== CPU USAGE ==="
top -bn1 | grep "Cpu(s)" | awk '{print "CPU Used: " 100 - $8 "%"}'

echo -e "\n=== MEMORY USAGE ==="
free -m | awk 'NR==2{printf "Used: %sMB / %sMB (%.2f%%) | Free: %sMB\n", $3, $2, $3*100/$2, $4}'

echo -e "\n=== DISK USAGE ==="
df -h / | awk 'NR==2{printf "Used: %s / %s (%s) | Free: %s\n", $3, $2, $5, $4}'

echo -e "\n=== TOP 5 CPU PROCESSES ==="
ps aux --sort=-%cpu | head -n 6 | awk '{print $1, $2, $3"%", $11}'

echo -e "\n=== TOP 5 MEMORY PROCESSES ==="
ps aux --sort=-%mem | head -n 6 | awk '{print $1, $2, $4"%", $11}'

echo -e "\n=== SYSTEM INFO ==="
echo "OS Version:    $(cat /etc/os-release | grep "PRETTY_NAME" | cut -d= -f2 | tr -d '"')"
echo "Uptime & Load: $(uptime)"
echo "Logged Users:  $(who | wc -l)"
echo "Failed Logins: $(grep -c "Failed" /var/log/auth.log 2>/dev/null || echo "N/A")"
