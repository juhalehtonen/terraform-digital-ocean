#!/bin/bash

# Run apt-get update, upgrade and install unattended-upgrades
sudo apt-get -y update && 
sudo apt-get -y upgrade &&
sudo apt-get -y install unattended-upgrades