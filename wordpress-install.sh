#!/bin/bash

# Remove the existing /var/www/html directory and all of its contents.
sudo rm -rf /var/www/html

# Install the unzip utility without prompting for confirmation.
sudo apt -y install unzip

# Download the latest WordPress package as a zip file and save it to /var/www/latest.zip.
sudo wget -O /var/www/latest.zip https://wordpress.org/latest.zip

# Unzip the WordPress package into the /var/www/ directory.
sudo unzip /var/www/latest.zip -d /var/www/

# Remove the downloaded zip file after extraction to clean up.
sudo rm /var/www/latest.zip

# Move the extracted WordPress directory to /var/www/html to make it the web root.
sudo mv /var/www/wordpress /var/www/html 

# Generate a random password for the WordPress database user using a mix of alphanumeric characters and symbols.
password=$(tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 25)

username=$(tr -dc 'A-Za-z' < /dev/urandom | head -c 25)

echo $password > creds.txt
echo $username >> creds.txt


# Create a new MySQL database named 'wordpress' if it doesn't already exist.
sudo mysql -e "CREATE DATABASE IF NOT EXISTS $username"

# Create a new MySQL user 'wpuser' with the generated password if the user doesn't already exist.
sudo mysql -e "CREATE USER IF NOT EXISTS $username@localhost identified by '$password'"

# Grant all privileges on the 'wordpress' database to the 'wpuser' user.
sudo mysql -e "GRANT ALL PRIVILEGES ON $username.* to $username@localhost"

# Apply the changes made to the MySQL privileges.
sudo mysql -e "FLUSH PRIVILEGES"

# Download a pre-configured wp-config.php file from an S3 bucket and save it to /var/www/html/.
# sudo wget -O /var/www/html/wp-config.php https://keffin-bucket.s3.amazonaws.com/wp-config.php

sudo mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

# Set permissions for the wp-config.php file to be readable and writable by the owner and readable by the group.
sudo chmod 640 /var/www/html/wp-config.php 

# Change the ownership of the /var/www/html directory and its contents to the 'www-data' user and group (the user/group typically used by web servers).
sudo chown -R www-data:www-data /var/www/html/

# Replace the placeholder 'password_here' in wp-config.php with the generated password.
sed -i "s/password_here/$password/g" /var/www/html/wp-config.php
sed -i "s/username_here/$username/g" /var/www/html/wp-config.php
sed -i "s/database_name_here/$username/g" /var/www/html/wp-config.php

SALT=$(curl -L https://api.wordpress.org/secret-key/1.1/salt/)
STRING='put your unique phrase here'
printf '%s\n' "g/$STRING/d" a "$SALT" . w | ed -s /var/www/html/wp-config.php

# (Optional) Navigate to the /etc/nginx/conf.d/ directory and create a new Nginx configuration file for WordPress.
# sudo cd /etc/nginx/conf.d/
# sudo touch wordpress.conf pull from s3bucket
