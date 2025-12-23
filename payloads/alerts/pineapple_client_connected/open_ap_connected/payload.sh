#!/bin/bash
# Title: Open AP Client Connected
# Description: Alerts when a device connects to the Pager Management AP 
# Author: Jordan Lanham
# Date: 2025-12-23
# Version: 1.0

alert_ssid="${_ALERT_CLIENT_CONNECTED_SSID:-}"
client_mac="${_ALERT_CLIENT_CONNECTED_CLIENT_MAC_ADDRESS:-unknown}"
ap_mac="${_ALERT_CLIENT_CONNECTED_AP_MAC_ADDRESS:-unknown}"
summary="${_ALERT_CLIENT_CONNECTED_SUMMARY:-Client connected: ${client_mac}}"
openAP_ssid="OnlyLans"


if [ "$alert_ssid" != "$openAP_ssid" ]; then
    exit 0
fi

ALERT "Open AP client connected: ${client_mac}"
RINGTONE Hak5_The_Planet:d=4,o=5,b=450:c6,c6,g5,c6,p,g5,a#5,c6,p,f5,g5,a#5,c6
LOG blue "Open AP client connected: client=${client_mac} ap=${ap_mac} ssid=${alert_ssid}"