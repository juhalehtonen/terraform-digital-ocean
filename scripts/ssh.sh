#!/bin/bash

echo "SSH"
# Disable root login
sed -i '/^PermitRootLogin[ \t]\+\w\+$/{ s//PermitRootLogin without-password/g; }' /etc/ssh/sshd_config
# Disable password authentication
sed -i '/^PasswordAuthentication[ \t]\+\w\+$/{ s//PasswordAuthentication no/g; }' /etc/ssh/sshd_config
# Restart SSH
service ssh restart