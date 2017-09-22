#!/bin/bash

# Run apt-get update, upgrade
DEBIAN_FRONTEND=noninteractive apt-get -y update &&
DEBIAN_FRONTEND=noninteractive apt-get -y upgrade