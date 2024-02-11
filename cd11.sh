#!/bin/bash

# Set the device and command
DEVICE="all"  # Change to "h872" or another device if needed
COMMAND="clean"  # Change to "build" or another command if needed



# Check if command is "clean"
if [ "$COMMAND" == "clean" ]; then
    echo "Cleaning..."

fi

# Check if device is set to "all"
if [ "$DEVICE" == "all" ]; then
    echo "Building for all devices..."

elif [ "$DEVICE" == "h872" ]; then
    echo "Building for h872..."


    # Build if the command is not "clean"
    if [ "$COMMAND" != "clean" ]; then
    echo "Building"
    fi
else
    echo "Building for the specified device: $DEVICE..."
    # Build for the specified device
    lunch "$DEVICE"

    # Build if the command is not "clean"
    if [ "$COMMAND" != "clean" ]; then
    echo "Building"
    fi
fi

# Additional build commands if needed
