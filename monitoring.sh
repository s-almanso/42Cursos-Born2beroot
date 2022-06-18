#!/bin/bash
used_mem=$(free -m | awk '$1 == "Mem:" {print $3}')
total_mem=$(free -m | awk '$1 == "Mem:" {print $2}')
p_mem=$(free -m | awk '$1 == "Mem:" {printf("%.2f"), $3/$2*100}')
used_disk=$(df -h --total | awk '$1 == "total" {print $3}')
total_disk=$(df -h --total | awk '$1 == "total" {print $2}')
p_disk=$(df -h --total | awk '$1 == "total" {print $5}')
total_con=$(ss -s | awk '$1 == "TCP" {print $3}')

echo "#Architecture: ${uname -a}"
echo "#CPU physical : ${nproc --all}"
echo "#vCPU : ${cat /proc/cpuinfo | grep "processor" | wc -l}"
echo "#Memory Usage: ${used_mem}/${total_mem}MB (${p_mem}%)}"
echo "#Disk Usage: ${used_disk}/${total_disk} (${p_disk}) "
echo "#CPU load: ${top -bn1 | awk 'NR == 3 {printf("%.2f"), $2 + $4}'}"
echo "#Last boot: ${who -b | awk '$1 == "system" {print $3 " " $4}'} "
echo "#LVM use: ${/usr/sbin/lvm pvdisplay | awk '$1 == "Allocatble" {print $2}'}"
echo "#Connexions TCP : ${total_con} ESTABLISHED"
echo "#User log: ${who | wc -l}"
echo "Network: IP ${hostname -I}(${ip a | awk '$1 == "link/ether" {print $2}'})"
echo "Sudo : ${journalctl | grep "COMMAND" | wc -l}"
