#!/bin/bash
set -e

if [ -z "${1:-}" ]
then
    echo "Usage: $0 <service-name>"
    exit 1
fi

sudo systemctl restart "$1"

if systemctl is-active --quiet "$1"
then
    echo "$1 is running."
else
    echo "$1 is not running."
    exit 1
fi

if curl --max-time 5 http://localhost >/dev/null 2>&1
then
    echo "Successful HTTP response."
else
    echo "HTTP response not getting."
    exit 1
fi
