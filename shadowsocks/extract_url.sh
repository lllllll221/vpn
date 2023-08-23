#!/bin/bash

CONFIG_FILE="ss-config.json" # path to your configuration file

# Extract parameters from the configuration file
METHOD=$(jq -r .method "$CONFIG_FILE")
PASSWORD=$(jq -r .password "$CONFIG_FILE")
SERVER=$(ip -o route get to 8.8.8.8.8 | sed -n 's/.*src \([0-9.]\+\).*/\1/p') # auto-detect server IP address.
PORT=$(jq -r .server_port "$CONFIG_FILE")

# Form and output the link
SS_URL="ss://$(echo -n "$METHOD:$PASSWORD" | base64)@$SERVER:$PORT"
echo "$SS_URL"
