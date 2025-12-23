#!/bin/bash
# Title: TEST
# Description: A quick test payload
# Author: Jordan Lanham
# Date: 2025-12-22
# Version: 1.0

LOG "Testing user payloads"
resp=$(TEST "This is a test payload" "Yes" "No")

case $? in
    $DUCKYSCRIPT_CANCELLED)
        LOG "User cancelled"
        exit 1
        ;;
    $DUCKYSCRIPT_REJECTED)
        LOG "Dialog rejected"
        exit 1
        ;;
    $DUCKYSCRIPT_ERROR)
        LOG "An error occurred"
        exit 1
        ;;
esac

LOG "User response: $resp"
