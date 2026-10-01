#!/bin/bash
set -e
if systemctl is-active --quiet nginx
then
    echo "Nginx is running."
else
    echo "Nginx is not running."
    exit 1
fi
if curl http://localhost >/dev/null 2>&1
then
    echo "Successful HTTP response."
else
    echo "HTTP response not getting."
    exit 1
fi
