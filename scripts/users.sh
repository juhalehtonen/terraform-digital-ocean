#!/bin/bash

# Add user without password
useradd -m developer -s /bin/bash
# Set empty and expired password for user, forcing change on first login
passwd -de developer
# Allow sudo for user
usermod -aG sudo developer