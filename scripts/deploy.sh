#!/bin/bash
set -e

if command -v nginx >/dev/null 2>&1
then
echo "Nginx is already installed."
else
echo "Nginx is not installed. Installing..."


if command -v dnf >/dev/null 2>&1
then
    sudo dnf install -y nginx
elif command -v apt >/dev/null 2>&1
then
    sudo apt update
    sudo apt install -y nginx
else
    echo "Unsupported package manager."
    exit 1
fi


fi

sudo cp web/index.html /usr/share/nginx/html/index.html

sudo systemctl enable nginx
sudo systemctl start nginx

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

echo "Deployment successful."
