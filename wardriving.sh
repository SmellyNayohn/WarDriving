#!/bin/bash

# Variables
ORIGINAL_INTERFACE=""  # Your Wi-Fi interface
MONITOR_INTERFACE=""         # Will be dynamically determined
SCRIPT_DIR="$(dirname "$(realpath "$0")")"  # Directory where the script is located
DEFAULT_FILENAME="capture-$(date +%Y%m%d%H%M%S).csv"  # Default file name if none is provided
OUTPUT_FILE=""

# Prompt user for a file name or use the default
read -p "Enter the output file name (or press Enter for default: $DEFAULT_FILENAME): " CUSTOM_FILENAME
if [ -z "$CUSTOM_FILENAME" ]; then
    OUTPUT_FILE="$SCRIPT_DIR/$DEFAULT_FILENAME"
else
    OUTPUT_FILE="$SCRIPT_DIR/$CUSTOM_FILENAME"
fi

# Function to enable monitor mode
enable_monitor_mode() {
    echo "[*] Enabling monitor mode on $ORIGINAL_INTERFACE..."
    airmon-ng start $ORIGINAL_INTERFACE

    # Check if monitor mode was enabled and detect the new interface name
    MONITOR_INTERFACE=$(iwconfig 2>/dev/null | grep 'Mode:Monitor' | awk '{print $1}')
    if [ -z "$MONITOR_INTERFACE" ]; then
        echo "[!] Failed to enable monitor mode. Check your setup."
        exit 1
    fi
    echo "[*] Monitor mode enabled on $MONITOR_INTERFACE."
}

# Function to disable monitor mode and restore managed mode
restore_managed_mode() {
    echo "[*] Restoring managed mode for $ORIGINAL_INTERFACE..."
    airmon-ng stop $MONITOR_INTERFACE
    systemctl restart NetworkManager
    echo "[*] Managed mode restored and NetworkManager restarted."
}

# Trap to restore managed mode on script exit
trap restore_managed_mode EXIT

# Main script
enable_monitor_mode

# Start airodump-ng and save output to the specified file
echo "[*] Starting airodump-ng on $MONITOR_INTERFACE. Data will be saved to $OUTPUT_FILE."
airodump-ng --write "${OUTPUT_FILE%.*}" --output-format csv $MONITOR_INTERFACE

# When airodump-ng stops, the script will restore managed mode
echo "[*] Capture saved to $OUTPUT_FILE. You can upload this file to Wigle.net."
