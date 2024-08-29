#!/bin/bash

# Remove the existing /var/www/html directory and all its contents to start fresh.
sudo rm -rf /var/www/html

# Install the unzip utility without asking for confirmation.
sudo apt -y install unzip

# Download the latest WordPress package as a zip file and save it to /var/www/latest.zip.
sudo wget -O /var/www/latest.zip https://wordpress.org/latest.zip

# Unzip the WordPress package into the /var/www/ directory.
sudo unzip /var/www/latest.zip -d /var/www/

# Remove the downloaded WordPress zip file after extraction to clean up space.
sudo rm /var/www/latest.zip

# Move the extracted WordPress directory to /var/www/html, making it the web root.
sudo mv /var/www/wordpress /var/www/html

# Generate a random password for the WordPress database user using alphanumeric characters.
password=$(tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 25)

# Generate a random username for the WordPress database user using alphabetic characters.
username=$(tr -dc 'A-Za-z' < /dev/urandom | head -c 25)

# Save the generated username and password to a file called creds.txt for reference.
echo $password > creds.txt
echo $username >> creds.txt

# Create a new MySQL database with the generated username as the database name if it doesn't already exist.
sudo mysql -e "CREATE DATABASE IF NOT EXISTS $username"

# Create a new MySQL user with the generated username and password if the user doesn't already exist.
sudo mysql -e "CREATE USER IF NOT EXISTS $username@localhost identified by '$password'"

# Grant all privileges on the generated database to the corresponding user.
sudo mysql -e "GRANT ALL PRIVILEGES ON $username.* to $username@localhost"

# Apply the changes made to MySQL privileges (necessary for them to take effect).
sudo mysql -e "FLUSH PRIVILEGES"

# (Optional) Download a pre-configured wp-config.php file from an S3 bucket (commented out).
# sudo wget -O /var/www/html/wp-config.php https://keffin-bucket.s3.amazonaws.com/wp-config.php

# Rename the wp-config-sample.php file to wp-config.php (WordPress configuration file).
sudo mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

# Set permissions for wp-config.php to be readable and writable by the owner and readable by the group.
sudo chmod 640 /var/www/html/wp-config.php

# Change the ownership of the /var/www/html directory and its contents to the 'www-data' user and group (used by the web server).
sudo chown -R www-data:www-data /var/www/html/

# Replace the placeholder 'password_here' in wp-config.php with the generated password.
sed -i "s/password_here/$password/g" /var/www/html/wp-config.php

# Replace the placeholder 'username_here' in wp-config.php with the generated username.
sed -i "s/username_here/$username/g" /var/www/html/wp-config.php

# Replace the placeholder 'database_name_here' in wp-config.php with the generated database name (same as the username).
sed -i "s/database_name_here/$username/g" /var/www/html/wp-config.php

# Fetch and insert WordPress security salts into wp-config.php, replacing the placeholder text.
SALT=$(curl -L https://api.wordpress.org/secret-key/1.1/salt/)
STRING='put your unique phrase here'
printf '%s\n' "g/$STRING/d" a "$SALT" . w | ed -s /var/www/html/wp-config.php

# (Optional) Navigate to the /etc/nginx/conf.d/ directory and create a new Nginx configuration file for WordPress.
# sudo cd /etc/nginx/conf.d/
# sudo touch wordpress.conf (uncomment to pull from S3 bucket or add custom config)
