#!/bin/bash
sudo apt -y install git
sudo cd /root/
sudo git clone https://github.com/kevwong16/wordpress-project.git
sudo chmod -R 755 wordpress-project
sudo bash wordpress-project/lemp-setup.sh
