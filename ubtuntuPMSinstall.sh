#!/bin/bash

#Instructions for setup

#Replace Wlan0 and Eth0 with your current connections

sudo apt-get install -yqq hostapd isc-dhcp-server iptables-persistent ssh samba

#edit /etc/dhcp/dhcpd.conf
#comment out 'domain-name' options and 'domain-name-server' options
#uncomment 'authoritative'
#add the following :
#subnet 192.168.42.0 netmask 255.255.255.0{
# range 192.168.42.10 192.168.42.50;
# option broadcast-address 192.168.42.255;
# option routers 192.168.42.1;
# default-lease-time 600;
# max-lease-time 7200;
# option domain-name "local";
# option domain-name-servers 8.8.8.8, 8.8.4.4;
# }

#edit /etc/default/isc-dhcp-server for the bottom line INTERFACES="wlan0"

#sudo ifdown wlan0

#edit /etc/network/interfaces
#comment out old wlan0 settings
#add the following:
# allow-hotplug wlan0
# iface wlan0 inet static
# address 192.168.42.1
# network 255.255.255.0

#sudo ifconfig wlan0 192.168.42.1

#Create and add /etc/hostapd/hostapd.conf, for my netbook I remove the drvier line to have it work
# interface=wlan0
# driver= 
# ssid=Mini_PMS
# Channel=1
# hw_mode=g
# wpa=2
# wpa_passphrase=MiniPMS1
# auth_algs=1
# wpa_key_mgmt=WPA-PSK WPA-EAP
# wpa_pairwise=CCMP TKIP
# rsn_pairwise=CCMP
# ieee80211n=1
# wme_enabled=1

#sudo edit /etc/default/hostapd and /etc/init.d/hostapd
# edit line with Daemon_Conf to "/etc/hostapd/hostapd.conf" and uncomment

#edit /etc/sysctl.conf, edit line with net.ipv4.ip_forward=1

sudo sh -c "echo 1 > /proc/sy/net/ipv4/ip-forward"

# edit iptables with 
#sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
#sudo iptables -A FORWARD -i eth0 -o wlan0 -m state --state Related,ESTABLISHED -j ACCEPT
#sudo iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT

#check changes with
#sudo iptables -t nat -S
#sudo iptables -S

#save changes with
#sudo sh -c "iptables-save > /etc/iptables/rules.v4"

#test Access point settings 
# sudo /usr/sbin/hostapd /etc/hostapd/hostapd.conf

#auto boot
#sudo update-rc.d hostapd enable
#sudo update-rc.d isc-dhcp-server enable

