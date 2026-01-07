#!/bin/bash

# Read CPU stats
read cpu user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat

prev_total=${prev_total:-0}
prev_idle=${prev_idle:-0}

total=$((user + nice + system + idle + iowait + irq + softirq + steal))
idle_total=$((idle + iowait))

diff_total=$((total - prev_total))
diff_idle=$((idle_total - prev_idle))

if [ "$diff_total" -ne 0 ]; then
  cpu_usage=$(( (100 * (diff_total - diff_idle)) / diff_total ))
else
  cpu_usage=0
fi

echo " ${cpu_usage}%"

prev_total=$total
prev_idle=$idle_total
