#!/bin/bash

BAT=$(acpi -b | grep -E -o '[0-9][0-9]?%')

# Set urgent flag below 5% or use orange below 20%
if [[ ${BAT%?} -le 30 ]]; then
  echo " $BAT"
elif [[ ${BAT%?} -le 65 ]]; then
  echo " $BAT"
elif [[ ${BAT%?} -le 80 ]]; then
  echo " $BAT"
else
  echo " $BAT"
fi

exit 0
