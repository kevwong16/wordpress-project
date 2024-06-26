#!/bin/bash
sudo apt -y install git # installs git
sudo git clone https://github.com/kevwong16/wordpress-project.git /root # clones git repository from the url into root directory
sudo chmod -R 755 wordpress-project # changes permissions of the directory and all its contents. The `755` permission grants read, write, and execute permissions to the owner and read and execute permissions to group and others
sudo bash wordpress-project/lemp-setup.sh # runs the lemp-setup.sh script located in the wordpress-project directory with Bash
