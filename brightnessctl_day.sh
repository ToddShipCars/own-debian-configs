#!/bin/bash
[ "$1" = -x ] && shift && set -x
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

brightnessctl set 3500

brightness-reset

yad --no-buttons --borders 30 --timeout 1 --text-align center \
  --on-top --undecorated --skip-taskbar --sticky \
  --text "<span size=\"x-large\">Brightness\n<b>$(cat /sys/class/backlight/intel_backlight/brightness)</b></span>" &