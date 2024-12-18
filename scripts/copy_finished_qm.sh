#!/bin/bash

# -----------------------------------
# copy.sh - Copy files based on step number
# Usage: ./copy.sh <step_number>
# Example: ./copy.sh 2
# -----------------------------------

# Function to display usage information
usage() {
    echo "Usage: $0 <step_number>"
    echo "Example: $0 2"
    exit 1
}

# Check if exactly one argument is provided
if [ $# -ne 1 ]; then
    echo "Error: Exactly one argument expected."
    usage
fi

step=$1

# Validate that the step number is a positive integer
if ! [[ "$step" =~ ^[0-9]+$ ]]; then
    echo "Error: Step number must be a positive integer."
    usage
fi

# Define the file extensions to copy
extensions=("inp" "out" "chk")

# Loop through each extension and perform the copy
for ext in "${extensions[@]}"; do
    src="1.${ext}"
    dest="step-${step}-${ext}"

    # Check if the source file exists
    if [ -e "$src" ]; then
        cp "$src" "$dest"
        echo "Copied $src to $dest"
    else
        echo "Warning: Source file $src does not exist. Skipping."
    fi
done

