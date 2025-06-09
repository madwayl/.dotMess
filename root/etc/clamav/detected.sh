#!/bin/bash

export LOG="/var/log/clamav/scan.log"
export TARGET="/"

SUMMARY_FILE=$(mktemp)
export SUMMARY_FILE

export SCAN_STATUS
export INFECTED_SUMMARY
export XUSERS

echo "------------ SCAN START ------------" >> "$LOG"
echo "Running scan on $(date)" >> "$LOG"

sudo clamdscan --log "$LOG" --infected --multiscan --fdpass "$TARGET" | sudo tee "$SUMMARY_FILE"

SCAN_STATUS="$?"
INFECTED_SUMMARY=$(grep Infected "${SUMMARY_FILE}")
rm "$SUMMARY_FILE"

if [[ "$SCAN_STATUS" -ne "0" ]] ; then

  # Send the alert to systemd logger if exist
  if [[ -n $(command -v systemd-cat) ]] ; then
    echo "Virus signature found - $INFECTED_SUMMARY" | /usr/bin/systemd-cat -t clamav -p emerg
  fi

  # Send an alert to all graphical users.
  read -r -a XUSERS <<< "$(who | awk '{print $1$NF}' | sort -u)"
  for XUSER in "${XUSERS[@]}"; do
    NAME=("${XUSER/(/ }")
    DISPLAY=${NAME[1]/)/}
    DBUS_ADDRESS=unix:path=/run/user/$(id -u "${NAME[0]}")/bus
    echo "run ${NAME[0]} - ${DISPLAY} - ${DBUS_ADDRESS} -" >> /tmp/testlog
    /usr/bin/sudo -u "${NAME[0]}" DISPLAY="${DISPLAY}" \
      DBUS_SESSION_BUS_ADDRESS="${DBUS_ADDRESS}" \
      PATH="${PATH}" \
      /usr/bin/notify-send -i security-low "Virus signature(s) found" "${INFECTED_SUMMARY}"
  done

fi
