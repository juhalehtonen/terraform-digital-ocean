#!/bin/bash

# Run apt-get update, upgrade and install unattended-upgrades
DEBIAN_FRONTEND=noninteractive apt-get -y update &&
DEBIAN_FRONTEND=noninteractive apt-get -y upgrade &&
DEBIAN_FRONTEND=noninteractive apt-get -y install unattended-upgrades