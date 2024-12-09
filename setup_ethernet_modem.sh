#!/usr/bin/env bash

if [ "$EUID" -ne 0 ]; then
    echo "Invalid User! User MUST be root, current user is $USER."
    echo "To change user execute: 'sudo su root'"
    exit 1
fi

echo "########################################################"
echo "#######       Raspberry Pi Ethernet & Modem       #######"
echo "#######                Setup Script               #######"
echo "########################################################"

# Update and upgrade system
apt update -y && apt upgrade -y

# Quectel Modem Setup
if lsusb | grep -q 'Quectel Wireless Solutions'; then
    if ls /sys/class/net | grep -q 'usb0'; then
        echo 'Quectel Modem already setup'
    else
        /bin/echo -n -e 'AT\r\n' > /dev/ttyUSB2
        sleep 0.5
        /bin/echo -n -e 'AT+QCFG="usbnet",1\r\n' > /dev/ttyUSB2
        sleep 0.5
        /bin/echo -n -e 'AT+CGDCONT=1,"IP","hologram"\r\n' > /dev/ttyUSB2
        sleep 0.5
        /bin/echo -n -e 'AT+CFUN=1,1\r\n' > /dev/ttyUSB2
        echo "Restarting Modem. Please wait..."
        sleep 5
    fi
else
    echo "Quectel Modem not detected, ensure USB is properly seated"
    exit 1
fi

# Ethernet Configuration
metric=$(ip route | grep usb0 | sed -n -e '0,/metric/{s/^.*metric \(.*$\)/\1/p}')
metric=$((metric + 1))

if ! nmcli | grep -q 'connected to ethernet_connection'; then
    nmcli con modify "Wired connection 1" con-name "ethernet_connection"
    nmcli c mod "ethernet_connection" ipv4.addresses 192.168.2.99/24 ipv4.method manual
    nmcli con mod "ethernet_connection" ipv4.gateway 192.168.2.1
    nmcli con mod "ethernet_connection" ipv4.dns "8.8.8.8,8.8.4.4,192.168.2.1"
    nmcli con mod 'ethernet_connection' ipv4.route-metric $metric
    nmcli c down "ethernet_connection"
    nmcli c up "ethernet_connection"
else
    echo "Ethernet connection already configured"
fi

echo "########################################################"
echo "#######          Setup Completed Successfully     #######"
echo "#######            Please Restart the Pi          #######"
echo "########################################################"
