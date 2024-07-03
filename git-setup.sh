#!/bin/bash
# sudo apt -y install git
sudo git clone https://github.com/kevwong16/wordpress-project.git /root/wordpress-project
sudo chmod -R 755 /root/wordpress-project
sudo bash /root/wordpress-project/lemp-setup.sh
