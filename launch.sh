#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done


xrandr --listactivemonitors | grep eDP-1 > /dev/null
intel_test=$?

if [ $intel_test != 0 ]; then
    echo "Intel"
    polybar -c ${HOME}/.config/polybar/config_intel center &
    polybar -c ${HOME}/.config/polybar/config_intel right &
    polybar -c ${HOME}/.config/polybar/config_intel third &
else
    echo "Modesetting"
    polybar -c ${HOME}/.config/polybar/config2 center &
    polybar -c ${HOME}/.config/polybar/config2 right &
    polybar -c ${HOME}/.config/polybar/config2 third &
fi;

# Launch bar1 and bar2
#polybar example &
#polybar -c ${HOME}/.config/polybar/config2 laptop &
#polybar -c ${HOME}/.config/polybar/config_3 title &
#polybar -c ${HOME}/.config/polybar/config_3 cpu &
#polybar -c ${HOME}/.config/polybar/config_3 memory & 
#polybar -c ${HOME}/.config/polybar/config_3 temperature &
#polybar -c ${HOME}/.config/polybar/config_3 workspace &
#polybar -c ${HOME}/.config/polybar/config_3 volume &
#polybar -c ${HOME}/.config/polybar/config_3 clock &
#polybar -c ${HOME}/.config/polybar/config_3 tray &

echo "Bars launched..."
