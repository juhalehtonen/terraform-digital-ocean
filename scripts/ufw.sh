#!/bin/bash

sudo ufw default deny incoming && # Deny all incoming traffic
sudo ufw default allow outgoing && # Allow all outgoing traffic
sudo ufw allow 22 && # Allow incoming SSH
sudo ufw allow proto tcp from any to any port 80,443 && # Allow incoming HTTP and HTTPS
sudo ufw --force enable # Enable UFW, bypass prompt with --force