#!/bin/bash

network="@NETWORK@"
net="eth0"
lan="eth1"
vpn="tun0"

case "$1" in
    start)
        iptables -I FORWARD -i ${lan} -o ${net} -s ${network} -m conntrack --ctstate NEW -j ACCEPT
        iptables -t nat -I POSTROUTING -o ${net} -s ${network} -j MASQUERADE
        iptables -I FORWARD -i ${lan} -o ${vpn} -s ${network} -m conntrack --ctstate NEW -j ACCEPT
        iptables -t nat -I POSTROUTING -o ${vpn} -s ${network} -j MASQUERADE
    ;;

    stop)
        iptables -D FORWARD -i ${lan} -o ${net} -s ${network} -m conntrack --ctstate NEW -j ACCEPT
        iptables -t nat -I POSTROUTING -o ${net} -s ${network} -j MASQUERADE
        iptables -I FORWARD -i ${lan} -o ${vpn} -s ${network} -m conntrack --ctstate NEW -j ACCEPT
        iptables -t nat -I POSTROUTING -o ${vpn} -s ${network} -j MASQUERADE
    ;;
esac
