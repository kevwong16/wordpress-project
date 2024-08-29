#!/bin/bash

# Update the package list to get information on the newest versions of packages and their dependencies.
sudo apt update -y

# Upgrade all the installed packages to their latest versions.
sudo apt upgrade -y

# Create an empty file /root/testing.txt to store the output of LEMP stack unit tests.
sudo touch /root/testing.txt

# Install the Nginx web server without prompting for confirmation.
sudo apt -y install nginx

# Start the Nginx service and enable it to start automatically on system boot.
sudo systemctl start nginx && sudo systemctl enable nginx

# Check the status of the Nginx service and save the output to /root/testing.txt.
sudo systemctl status nginx > /root/testing.txt

# Install the MariaDB database server without prompting for confirmation.
sudo apt -y install mariadb-server

# Start the MariaDB service and enable it to start automatically on system boot.
sudo systemctl start mariadb && sudo systemctl enable mariadb

# Check the status of the MariaDB service and append the output to /root/testing.txt.
systemctl status mariadb >> /root/testing.txt

# Install PHP and commonly used PHP extensions without prompting for confirmation.
sudo apt -y install php php-cli php-common php-imap php-fpm php-snmp php-xml php-zip php-mbstring php-curl php-mysqli php-gd php-intl

# Check the installed PHP version and append the output to /root/testing.txt.
sudo php -v >> /root/testing.txt

# Update the PHP configuration to increase the maximum upload file size to 512M.
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 512M/g' /etc/php/8.3/fpm/php.ini

# Update the PHP configuration to increase the maximum POST data size to 512M.
sed -i 's/post_max_size = 8M/post_max_size = 512M/g' /etc/php/8.3/fpm/php.ini

# Restart the PHP-FPM service to apply the changes made to the PHP configuration.
sudo systemctl restart php8.3-fpm

# Stop the Apache web server since Nginx is being used as the web server.
sudo systemctl stop apache2

# Disable the Apache service from starting automatically on system boot.
sudo systemctl disable apache2

# (Optional) Fully remove the Apache web server, including configuration files.
# sudo apt remove --purge apache2

# Rename the default Apache test page to avoid conflicts with Nginx.
sudo mv /var/www/html/index.html /var/www/html/index.html.old

# Replace the default Nginx configuration with a custom one for the WordPress project.
sudo mv /home/ubuntu/wordpress-project/nginx.conf /etc/nginx/conf.d/nginx.conf

# Set the domain name and elastic IP for the WordPress site.
my_domain=REPLACE_DOMAIN
elastic_ip=REPLACE_MY_ELASTIC_IP

# Set the Cloudflare API token and zone ID for managing DNS records.
CF_API=REPLACE_CF_API
CF_ZONE_ID=REPLACE_CF_ZONE_ID

# Create a DNS A record for the domain on Cloudflare, pointing to the Elastic IP.
curl --request POST \
  --url https://api.cloudflare.com/client/v4/zones/$CF_ZONE_ID/dns_records \
  --header 'Content-Type: application/json' \
  --header "Authorization: Bearer $CF_API" \
  --data '{
  "content": "'"$elastic_ip"'",
  "name": "'"$my_domain"'",
  "proxied": true,
  "type": "A",
  "comment": "Automatically adding A record",
  "tags": [],
  "ttl": 3600
}'

# Update the Nginx server name configuration with the actual domain name.
sed -i "s/SERVERNAME/$my_domain/g" /etc/nginx/conf.d/nginx.conf

# Test the Nginx configuration for syntax errors, and reload Nginx if the test is successful.
nginx -t && systemctl reload nginx

# Run a script to install SSL certificates using Certbot (uncomment to use).
# sudo bash /root/wordpress-project/certbot-ssl-install.sh
