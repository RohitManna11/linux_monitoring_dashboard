#!/bin/bash
echo "System Monitoring Stats - $(date)"
echo "----------------------------------"
echo "CPU Usage:"
vmstat 1 2
echo ""

echo "Memory Usage:"
free -m
echo ""

echo "Disk Usage:"
df -h
echo ""

echo "Running Processes (Top 10 by CPU usage):"
ps -eo pid,comm,%cpu --sort=-%cpu | head -10
echo ""

echo "Network Connections:"
netstat -tunlp
