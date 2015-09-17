#!/bin/bash
IPT="/sbin/iptables"

# Your DNS servers you use: cat /etc/resolv.conf
DNS_SERVER=$(cat /etc/resolv.conf  | grep -v '^#' | grep nameserver | awk '{pri$

for ip in $DNS_SERVER
do
        echo "Allowing DNS lookups (tcp, udp port 53) to server '$ip'"
        $IPT -A OUTPUT -p udp -d $ip --dport 53 -m state --state NEW,ESTABLISHE$
        $IPT -A INPUT  -p udp -s $ip --sport 53 -m state --state ESTABLISHED   $
        $IPT -A OUTPUT -p tcp -d $ip --dport 53 -m state --state NEW,ESTABLISHE$
        $IPT -A INPUT  -p tcp -s $ip --sport 53 -m state --state ESTABLISHED   $
done
    
$IPT -A OUTPUT -p tcp -d 0.0.0.0/0 --dport 465 -m state --state NEW,ESTABLISHED$
$IPT -A INPUT  -p tcp -s 0.0.0.0/0 --sport 465 -m state --state ESTABLISHED    $


