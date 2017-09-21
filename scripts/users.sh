#!/bin/bash

# Add user without password
useradd -m  username -s /bin/bash
# Set empty and expired password for user, forcing change on first login
passwd -de username
# Allow sudo for user
usermod -aG sudo username