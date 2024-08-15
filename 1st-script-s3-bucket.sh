#!/bin/bash

# Download the git-setup.sh script from an S3 bucket and save it to /root/.
sudo wget -O /root/git-setup.sh https://keffin-bucket.s3.amazonaws.com/git-setup.sh

# Change the permissions of the downloaded script to make it executable by the owner, group, and others.
sudo chmod 755 /root/git-setup.sh

# Execute the git-setup.sh script with elevated privileges.
sudo bash /root/git-setup.sh
