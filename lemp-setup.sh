#!/bin/bash
sudo apt -y update
sudo apt -y upgrade
sudo touch /root/testing.txt # this file will contain the output of our LEMP stack unit tests
sudo apt -y install nginx
sudo systemctl start nginx && sudo systemctl enable nginx # this starts and enables nginx on a server reboot. The 2nd command will only run if the first command is successful
sudo systemctl status nginx >> /root/testing.txt 2>&1 #append incase any other script outputs into testing.txt also stdout and stderr will append now "2>&1"
#if you manage to automate the pulling of nginx config from a source it will be wise to unit test nginx -t for valid config syntax as well 
sudo apt -y install mariadb-server
sudo systemctl start mariadb && sudo systemctl enable mariadb
systemctl status mariadb >> /root/testing.txt 2>&1 #stdout and stderr will append now "2>&1"
sudo apt -y install php php-cli php-common php-imap php-fpm php-snmp php-xml php-zip php-mbstring php-curl php-mysqli php-gd php-intl
sudo php -v >> /root/testing.txt 2>&1 #stdout and stderr will append now "2>&1"
sudo mv /var/www/html/index.html /var/www/html/index.html.old # rename apache testing page
