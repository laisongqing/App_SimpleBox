#!/bin/bash

# Add a new user "boxadmin" and add "boxadmin" to the sudo group.
useradd -m boxadmin
usermod -aG sudo boxadmin

# Change "boxadmin" user's password to plaintext "boxadmin"
echo "boxadmin:boxadmin" | chpasswd

# Check whether SSH service exists. If not, install it.
if ! systemctl status ssh &> /dev/null; then
    echo "SSH service not found. Installing..."
    apt update
    apt install -y openssh-server
    systemctl start ssh
    systemctl enable ssh
    echo "SSH service installed and started."
else
    echo "SSH service already installed."
fi

# Add a new user "allen" and set password
useradd -m allen
echo "Setting password for user allen..."
echo "allen:1qaz2wsx" | chpasswd

# Add "allen" to the sudoers file
echo "allen ALL=(ALL:ALL) ALL" >> /etc/sudoers

# Create a new file named user.txt in allen's home directory
echo "FNDVTYKRIUQeQP@d" > /home/allen/user.txt

echo "External penetration vulnerabilities set successfully."

# Create a file named root.txt in root's home directory
echo "6VU#VBOgx!n8038a" > /root/root.txt

# Install sudo package if not already installed
if ! dpkg -l | grep -Fq 'sudo'; then
  apt-get update && apt-get install -y sudo
fi

# Create a file with LFI vulnerability in allen's home directory
echo "<?php include('/etc/passwd'); ?>" > /home/allen/vuln_file.php
chown allen:allen /home/allen/vuln_file.php
chmod 644 /home/allen/vuln_file.php
chmod 640 /etc/shadow

echo "Internal diffusion defects set successfully."
