#!/bin/bash

# Create an empty file /root/testing.txt to store the output of LEMP stack unit tests.
sudo touch /root/testing.txt

# Install Nginx web server without prompting for confirmation.
sudo apt -y install nginx

# Start the Nginx service and enable it to start on boot.
# The second command will only execute if the first one is successful.
sudo systemctl start nginx && sudo systemctl enable nginx

# Check the status of Nginx and append the output to /root/testing.txt.
sudo systemctl status nginx > /root/testing.txt

# Install MariaDB server without prompting for confirmation.
sudo apt -y install mariadb-server

# Start the MariaDB service and enable it to start on boot.
sudo systemctl start mariadb && sudo systemctl enable mariadb

# Check the status of MariaDB and append the output to /root/testing.txt.
systemctl status mariadb >> /root/testing.txt

# Install PHP and various PHP extensions without prompting for confirmation.
sudo apt -y install php php-cli php-common php-imap php-fpm php-snmp php-xml php-zip php-mbstring php-curl php-mysqli php-gd php-intl

# Check the installed PHP version and append the output to /root/testing.txt.
sudo php -v >> /root/testing.txt

# Stop the Apache web server since Nginx is being used.
sudo systemctl stop apache2

# Disable Apache from starting automatically on system boot.
sudo systemctl disable apache2

# (Optional) Fully remove Apache2, including configuration files.
# sudo apt remove --purge apache2

# Rename the default Apache test page to avoid conflicts.
sudo mv /var/www/html/index.html /var/www/html/index.html.old

# Replace the default Nginx configuration with a custom one for the WordPress project.
sudo mv /root/wordpress-project/nginx.conf /etc/nginx/conf.d/nginx.conf

# Define the DNS record for the WordPress site.
dns_record="wp.kevwong.uk"

# Update the server name in the Nginx configuration file with the DNS record.
sed -i "s/SERVERNAME/$dns_record/g" /etc/nginx/conf.d/nginx.conf

# Test the Nginx configuration for syntax errors and reload Nginx if the test is successful.
nginx -t && systemctl reload nginx

# Run a script to install SSL certificates using Certbot.
sudo bash /root/wordpress-project/certbot-ssl-install.sh
