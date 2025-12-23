#!/bin/bash
# Title: TEST_DUAL_INPUT
# Description: A quick test payload
# Author: Jordan Lanham
# Date: 2025-12-22
# Version: 1.0

LOG "Testing user payloads"
input_one=$(TEXT_PICKER "Input one" "")
case $? in
    $DUCKYSCRIPT_CANCELLED|$DUCKYSCRIPT_REJECTED)
        LOG "User cancelled"
        exit 1
        ;;
    $DUCKYSCRIPT_ERROR)
        LOG "An error occurred"
        exit 1
        ;;
esac

input_two=$(TEXT_PICKER "Input two" "")
case $? in
    $DUCKYSCRIPT_CANCELLED|$DUCKYSCRIPT_REJECTED)
        LOG "User cancelled"
        exit 1
        ;;
    $DUCKYSCRIPT_ERROR)
        LOG "An error occurred"
        exit 1
        ;;
esac

confirm=$(CONFIRMATION_DIALOG "Use these values?" )
case $? in
    $DUCKYSCRIPT_REJECTED)
        LOG "Dialog rejected"
        exit 1
        ;;
    $DUCKYSCRIPT_ERROR)
        LOG "An error occurred"
        exit 1
        ;;
esac

case "$confirm" in
    $DUCKYSCRIPT_USER_CONFIRMED)
        LOG "User confirmed"
        ;;
    $DUCKYSCRIPT_USER_DENIED)
        LOG "User denied"
        exit 0
        ;;
    *)
        LOG "Unknown confirmation response: $confirm"
        exit 1
        ;;
esac

LOG "Input one: $input_one"
LOG "Input two: $input_two"