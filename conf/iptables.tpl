#!/bin/bash

# Rules LAN <=> NET
iptables -I FORWARD -i eth1 -o eth0 -s @NETWORK@ -m conntrack --ctstate NEW -j ACCEPT
iptables -t nat -I POSTROUTING -o eth0 -s @NETWORK@ -j MASQUERADE

# Rules LAN <=> VPN
iptables -I FORWARD -i eth1 -o tun0 -s @NETWORK@ -m conntrack --ctstate NEW -j ACCEPT
iptables -t nat -I POSTROUTING -o tun0 -s @NETWORK@ -j MASQUERADE
