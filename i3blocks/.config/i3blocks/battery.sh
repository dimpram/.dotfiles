#!/bin/bash

BAT=$(acpi -b | grep -E -o -m 1 '[0-9][0-9][0-9]?%')
STATUS=$(acpi -b | awk '{print $3;exit;}')

if [[ ${STATUS} == "Discharging," ]]; then
  if [[ ${BAT%?} -le 15 ]]; then
    echo " $BAT"
    echo " $BAT"   # Adding it a second for the hex color to apply
    echo "#FF0000"
  elif [[ ${BAT%?} -le 30 ]]; then
    echo " $BAT"
  elif [[ ${BAT%?} -le 65 ]]; then
    echo " $BAT"
  elif [[ ${BAT%?} -le 80 ]]; then
   echo " $BAT"
  else
    echo " $BAT"
  fi
elif [[ ${STATUS} == "Charging," ]]; then
  echo " $BAT"
elif [[ ${STATUS} == "Full," ]] || [[ ${STATUS} == "Not" ]]; then
  echo "FULL $BAT"
fi

exit 0
