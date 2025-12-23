#!/bin/bash
# Title: TEST_CALCULATOR
# Description: A quick calculator payload
# Author: Jordan Lanham
# Date: 2025-12-23
# Version: 1.0

LOG "Calculator: collecting inputs"

num_a=$(NUMBER_PICKER "First number" 1)
case $? in
	$DUCKYSCRIPT_CANCELLED|$DUCKYSCRIPT_REJECTED)
		LOG "User cancelled first number"
		exit 0
		;;
	$DUCKYSCRIPT_ERROR)
		LOG red "Error getting first number"
		exit 1
		;;
esac

op=$(TEXT_PICKER "Operator (+ - * /)" "+")
case $? in
	$DUCKYSCRIPT_CANCELLED|$DUCKYSCRIPT_REJECTED)
		LOG "User cancelled operator"
		exit 0
		;;
	$DUCKYSCRIPT_ERROR)
		LOG red "Error getting operator"
		exit 1
		;;
esac

num_b=$(NUMBER_PICKER "Second number" 1)
case $? in
	$DUCKYSCRIPT_CANCELLED|$DUCKYSCRIPT_REJECTED)
		LOG "User cancelled second number"
		exit 0
		;;
	$DUCKYSCRIPT_ERROR)
		LOG red "Error getting second number"
		exit 1
		;;
esac

confirm=$(CONFIRMATION_DIALOG "Compute: ${num_a} ${op} ${num_b} ?")
case $? in
	$DUCKYSCRIPT_REJECTED)
		LOG "User rejected confirmation"
		exit 0
		;;
	$DUCKYSCRIPT_ERROR)
		LOG red "Error showing confirmation dialog"
		exit 1
		;;
esac

case "$confirm" in
	$DUCKYSCRIPT_USER_DENIED)
		LOG "User denied calculation"
		exit 0
		;;
	$DUCKYSCRIPT_USER_CONFIRMED)
		;;
	*)
		LOG red "Unknown confirmation response: $confirm"
		exit 1
		;;
esac

op=${op//[[:space:]]/}
if [ -z "$op" ]; then
	ERROR_DIALOG "Operator cannot be empty"
	LOG red "Empty operator"
	exit 1
fi

result=""
case "$op" in
	"+")
		result=$((num_a + num_b))
		;;
	"-")
		result=$((num_a - num_b))
		;;
	"*")
		result=$((num_a * num_b))
		;;
	"/")
		if [ "$num_b" -eq 0 ]; then
			ERROR_DIALOG "Divide by zero"
			LOG red "Divide by zero attempt: ${num_a} / ${num_b}"
			exit 1
		fi
		result=$((num_a / num_b))
		;;
	*)
		ERROR_DIALOG "Unsupported operator: $op"
		LOG red "Unsupported operator: $op"
		exit 1
		;;
esac

LOG green "Result: ${num_a} ${op} ${num_b} = ${result}"
ALERT "${num_a} ${op} ${num_b} = ${result}"

