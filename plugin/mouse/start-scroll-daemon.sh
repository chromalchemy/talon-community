#!/bin/bash
cd "$(dirname "$0")"

# Check if the daemon is already running
if pgrep -f "/usr/local/bin/bb scroll.clj daemon" > /dev/null; then
  echo "Scroll daemon already running."
else
  /usr/local/bin/bb scroll.clj daemon > /dev/null 2>&1 &
  echo "Started scroll daemon."
fi