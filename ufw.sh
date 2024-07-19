#!/usr/bin/env bash
source .env

for port in $REMOTE_TUNNEL_MAIN_FORWARD_PORT $REMOTE_TUNNEL_BACKUP_FORWARD_PORT; do
    for subnet in 10.0.0.0/8 172.16.0.0/12 192.168.0.0/16 fe80::/64; do
        ufw allow from "$subnet" to any port $port proto tcp
    done
done

for port in $REMOTE_TUNNEL_MAIN_FORWARD_PORT $REMOTE_TUNNEL_BACKUP_FORWARD_PORT; do
    ufw allow $port/tcp
done

ufw reload
