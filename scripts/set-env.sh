#!/bin/bash

# Function to update or add a global variable to ~/.bashrc
update_env_variable() {
	local variable_name="$1"
	local new_value="$2"
	local grep_result

	# Check if the variable is already set in ~/.bashrc
	grep_result=$(grep -E "^export $variable_name=" ~/.bashrc)

	if [ -n "$grep_result" ]; then
		# Variable exists, replace its value
		sed -i "s/^export $variable_name=.*/export $variable_name=\"$new_value\"/" ~/.bashrc
	else
		# Variable does not exist, add it to ~/.bashrc
		echo -e "\nexport $variable_name=\"$new_value\"\n" >>~/.bashrc
	fi
}

# Set global variables
update_env_variable "STREAM_NUM" "25"
update_env_variable "OUT_NUM" "95"
