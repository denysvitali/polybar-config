#!/bin/sh
BT_NAME=$(bluetoothctl info | grep 'Name: ' | awk -F ': ' '{print $2}')

if [ -z "$BT_NAME" ]; then
  echo ""
  exit;
fi

echo -e "\uf293 $BT_NAME"
