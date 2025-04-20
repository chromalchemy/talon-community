#!/bin/bash
cd "$(dirname "$0")"
/usr/local/bin/bb scroll.clj daemon > /dev/null 2>&1 &
