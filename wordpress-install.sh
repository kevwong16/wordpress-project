#!/bin/bash
sudo cd /var/www/html/
sudo apt -y install unzip
sudo wget https://wordpress.org/latest.zip
sudo unzip latest.zip
sudo rm latest.zip
sudo mariadb -u root
# create database wordpress;
# create user wpuser@localhost identified by 'theclassof92';
# grant all privileges on wordpress.* to wpuser@localhost;
# flush privileges;
# exit;
# wget wp-config.php from s3bucket
sudo cd wordpress/
sudo cp wp-config-sample.php wp-config.php
sudo vi wp-config.php
# add db name, username and password
sudo chmod 640 wp-config.php
sudo chown www-data:www-data /var/www/html/wordpress/ -R
sudo cd /etc/nginx/conf.d/
# sudo touch wordpress.conf pull from s3bucket
sudo vi /etc/nginx/conf.d/wordpress.conf
# server_name ec2-50-19-145-199.compute-1.amazonaws.com;
# root /var/www/html/wordpress/;
sudo nginx -t
sudo systemctl reload nginx
