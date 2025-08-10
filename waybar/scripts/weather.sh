#!/bin/bash

API_KEY="f1dc7a87f7680fa366e7fcaf8e79d743"
CITY="Mumbai,IN"
UNITS="metric"  # or imperial for °F
URL="https://api.openweathermap.org/data/2.5/weather?q=${CITY}&appid=${API_KEY}&units=${UNITS}"

weather=$(curl -sf "$URL")
if [ ! -z "$weather" ]; then
    temp=$(echo "$weather" | jq ".main.temp" | cut -d "." -f 1)
    desc=$(echo "$weather" | jq -r ".weather[0].description")
    icon=$(echo "$weather" | jq -r ".weather[0].icon")

    # Optional: convert icon code to emoji
    case $icon in
        01d) emoji="☀️" ;;
        01n) emoji="🌙" ;;
        02d) emoji="🌤️" ;;
        02n) emoji="☁️" ;;
        03d|03n) emoji="☁️" ;;
        04d|04n) emoji="☁️" ;;
        09d|09n) emoji="🌧️" ;;
        10d) emoji="🌦️" ;;
        10n) emoji="🌧️" ;;
        11d|11n) emoji="⛈️" ;;
        13d|13n) emoji="❄️" ;;
        50d|50n) emoji="🌫️" ;;
        *) emoji="❓" ;;
    esac

    echo "${emoji} ${temp}°C "
else
    echo "❌"
fi

