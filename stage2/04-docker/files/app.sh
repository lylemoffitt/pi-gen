#!/bin/bash

GW=$(ip route | awk '{print $3}' | head -1)

PORT=31415                  # Destination port

PING_COUNT=1                # Number of ping packets to send per attempt
WAIT_INTERVAL=2             # Seconds to wait between ping attempts


while ! ping -c "$PING_COUNT" "$GW" &>/dev/null; do
    sleep "$WAIT_INTERVAL"
done


for (( i=1; i>0; i++ )); do
  echo "$i" | nc -u -p $PORT $GW $PORT
done