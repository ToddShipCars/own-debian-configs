#!/bin/bash
[ "$1" = -x ] && shift && set -x
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

currentBrightness=$(brightnessctl g)
maxBrightness=$(brightnessctl m)

scale=1000
if (( ${currentBrightness} < ${maxBrightness}/50 )); then
  scale=100
elif (( ${currentBrightness} < ${maxBrightness}/20 )); then
  scale=250
elif (( ${currentBrightness} < ${maxBrightness}/10 )); then
  scale=500
fi

if (( ${currentBrightness} <= 1 )); then
  brightnessctl set 0
elif (( ${currentBrightness} <= 100 )); then
  brightnessctl set 1
else
  brightnessctl set ${scale}-
fi

yad --no-buttons --borders 30 --timeout 1 --text-align center \
  --on-top --undecorated --skip-taskbar --sticky \
  --text "<span size=\"x-large\">Brightness\n<b>$(cat /sys/class/backlight/intel_backlight/brightness)</b></span>" &
