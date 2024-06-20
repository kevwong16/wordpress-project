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

# server {
#   listen 80;
#   listen [::]:80;
#   server_name ec2-50-19-145-199.compute-1.amazonaws.com;
#   root /var/www/html/wordpress/;
#   index index.php index.html index.htm index.nginx-debian.html;

#   error_log /var/log/nginx/wordpress.error;
#   access_log /var/log/nginx/wordpress.access;

#   location / {
#     try_files $uri $uri/ /index.php;
#   }

#    location ~ ^/wp-json/ {
#      rewrite ^/wp-json/(.*?)$ /?rest_route=/$1 last;
#    }

#   location ~* /wp-sitemap.*\.xml {
#     try_files $uri $uri/ /index.php$is_args$args;
#   }

#   error_page 404 /404.html;
#   error_page 500 502 503 504 /50x.html;

#   client_max_body_size 20M;

#   location = /50x.html {
#     root /usr/share/nginx/html;
#   }

#   location ~ \.php$ {
#     fastcgi_pass unix:/run/php/php8.3-fpm.sock;
#     fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
#     include fastcgi_params;
#     include snippets/fastcgi-php.conf;
#     fastcgi_buffers 1024 4k;
#     fastcgi_buffer_size 128k;
#   }

#   #enable gzip compression
#   gzip on;
#   gzip_vary on;
#   gzip_min_length 1000;
#   gzip_comp_level 5;
#   gzip_types application/json text/css application/x-javascript application/javascript image/svg+xml;
#   gzip_proxied any;

#   # A long browser cache lifetime can speed up repeat visits to your page
#   location ~* \.(jpg|jpeg|gif|png|webp|svg|woff|woff2|ttf|css|js|ico|xml)$ {
#        access_log        off;
#        log_not_found     off;
#        expires           360d;
#   }

#   # disable access to hidden files
#   location ~ /\.ht {
#       access_log off;
#       log_not_found off;
#       deny all;
#   }
# }

sudo nginx -t
sudo systemctl reload nginx
