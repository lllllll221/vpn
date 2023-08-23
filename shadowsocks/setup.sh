#!/bin/bash

PORT=8000 # If port 8000 is blocked on your network, change it to something else
PASSWORD=$( cat /dev/urandom | tr --delete --complement 'a-z0-9' | head --bytes=16 )
IP=$(ip -o route get to 8.8.8.8 | sed -n 's/.*src \([0-9.]\+\).*/\1/p')
ENCRYPTION=chacha20-ietf-poly1305

function config() {
cat > "$1" <<EOF
{
    "server":"0.0.0.0",
    "server_port":$2,
    "local_port":1080,
    "password":"$3",
    "timeout":300,
    "method":"$ENCRYPTION"
}
EOF
}

function generate_hash() {
     echo -n "$1":"$2" | base64
}

function config_info() {
    echo "---------------------------------"
    echo "Your shadowsocks proxy configuration:"
    echo "URL: ss://$(generate_hash chacha20-ietf-poly1305 $PASSWORD)@$IP:$PORT"
    echo
    echo "Windows Client : https://github.com/shadowsocks/shadowsocks-windows/releases"
    echo "Android Client : https://play.google.com/store/apps/details?id=com.github.shadowsocks"
    echo "iOS Client : https://itunes.apple.com/app/outline-app/id1356177741"
    echo "Other Clients : https://shadowsocks.org/en/download/clients.html"
    echo "---------------------------------"
    echo
    echo "IP : $IP"
    echo "Port: $PORT"
    echo "Password: $PASSWORD"
    echo "---------------------------------"
}

# Install shadowsocks on Ubuntu
apt-get update
apt-get install -y shadowsocks-libev
ufw allow "$PORT"/tcp

# Create a config file
mkdir -p /etc/shadowsocks-libev
config /etc/shadowsocks-libev/config.json "$PORT" "$PASSWORD"

# Run shadowsocks
systemctl enable shadowsocks-libev
systemctl restart shadowsocks-libev
config_info