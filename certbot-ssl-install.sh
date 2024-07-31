#!/bin/bash

# Update package list and install Certbot and Certbot Nginx plugin
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y certbot python3-certbot-nginx

# Define your email
EMAIL="kevin.wong@apprentice.ua92.ac.uk"

# Define your domain(s)
DOMAIN="wp.kevwong.uk"

# Use Certbot to obtain and install the SSL certificate for the specified domain
sudo certbot --nginx --non-interactive --agree-tos --email $EMAIL -d $DOMAIN

# Nginx unit test that will reload Nginx to apply changes ONLY if the test is successful
sudo nginx -t && sudo systemctl reload nginx

# Run the WordPress installation script
sudo bash /root/wordpress-project/wordpress-install.sh
