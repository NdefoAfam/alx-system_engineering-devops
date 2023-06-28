#!/bin/bash

# Update the package index
sudo apt update

# Install nginx
sudo apt install -y nginx

# Configure nginx to listen on port 80
sudo sed -i 's/listen\s*80;/listen 80 default_server;/g' /etc/nginx/sites-available/default

# Restart nginx
sudo service nginx restart

# Create a default index.html file with "Hello World!" message
echo "<html><body><h1>Hello World!</h1></body></html>" | sudo tee /var/www/html/index.html > /dev/null

# Make sure nginx is running
nginx_process=$(ps aux | grep "[n]ginx")
if [ -z "$nginx_process" ]; then
    sudo service nginx start
fi

