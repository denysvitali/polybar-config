#!/bin/bash
API_KEY="745f7716ffd4c29972bbaf9d9fb8cd6b"
LOCATION="Lugano, Switzerland"
tempfile=$(mktemp)
curl "https://api.openweathermap.org/data/2.5/weather?q=$LOCATION&units=metric&APPID=$API_KEY" 2>/dev/null 1>$tempfile
return_code=$?

if [ "$return_code" -ne "0" ]; then
  echo "Not available"
  exit
fi

temperature=$(cat $tempfile | jq -r .main.temp | awk '{print int($1+0.5)}')
condition=$(cat $tempfile | jq -r .weather[0].main)
id=$(cat $tempfile | jq -r .weather[0].id)
icon=""

emoji=true

if [ "$emoji" = true ]; then
  if [ $id -eq 800 ]; then
    # Clear
    icon="🌞";
  elif [ $id -ge 800 ] && [ $id -lt 900 ]; then
    # Clouds
    icon="☁️";
  elif [ $id -ge 300 ] && [ $id -lt 400 ]; then
    # Drizzle
    icon="⛆";
  elif [ $id -ge 500 ] && [ $id -lt 600 ]; then
    # Rain
    icon="🌧️";
  elif [ $id -ge 200 ] && [ $id -lt 300 ]; then
    # Thunderstorm
    icon="🌩️";
  elif [ $id -ge 600 ] && [ $id -lt 700 ]; then
    # Snow
    icon="❄️";
  fi
else
  if [ "$id" -eq "800" ]; then
    icon=$(printf "\uf185");
  elif [ $id -ge 800 ] && [ $id -lt 900 ]; then
    # Clouds
    icon=$(printf "\uf0c2");
  elif [ $id -ge 500 ] && [ $id -lt 600 ]; then
    # Rain
    icon=$(printf "\uf043");
  elif [ $id -ge 200 ] && [ $id -lt 300 ]; then
    # Thunderstorm
    icon=$(printf "\uf0e7");
  elif [ $id -ge 600 ] && [ $id -lt 700 ]; then
    # Snow
    icon=$(printf "\uf2dc");
  fi
fi


echo "$icon  $condition, $temperature°"
