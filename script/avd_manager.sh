#!/bin/bash

# AVD Manager using rofi for Flutter projects
# This script provides a GUI interface to create and manage Android emulators

# Colors for better output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if rofi is installed
if ! command -v rofi &> /dev/null; then
    echo -e "${RED}Rofi is not installed. Please install it first.${NC}"
    echo "For Ubuntu/Debian: sudo apt install rofi"
    echo "For Arch Linux: sudo pacman -S rofi"
    echo "For Fedora: sudo dnf install rofi"
    exit 1
fi

# Check if alacritty is installed
if ! command -v alacritty &> /dev/null; then
    echo -e "${RED}Alacritty is not installed. Please install it first.${NC}"
    echo "For Ubuntu/Debian: sudo apt install alacritty"
    echo "For Arch Linux: sudo pacman -S alacritty"
    echo "For Fedora: sudo dnf install alacritty"
    exit 1
fi

# Environment variables check
setup_environment() {
    # Check if ANDROID_HOME is set
    if [ -z "$ANDROID_HOME" ]; then
        export ANDROID_HOME=$HOME/android-sdk
        echo -e "${YELLOW}ANDROID_HOME was not set. Setting to default: $ANDROID_HOME${NC}"
    fi

    # Check if ANDROID_SDK_ROOT is set
    if [ -z "$ANDROID_SDK_ROOT" ]; then
        export ANDROID_SDK_ROOT=$ANDROID_HOME
        echo -e "${YELLOW}ANDROID_SDK_ROOT was not set. Setting to: $ANDROID_SDK_ROOT${NC}"
    fi

    # Add necessary directories to PATH if not already included
    if [[ ":$PATH:" != *":$ANDROID_HOME/cmdline-tools/latest/bin:"* ]]; then
        export PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$PATH
        echo -e "${YELLOW}Added Android tools to PATH${NC}"
    fi

    # Check if avdmanager is available
    if ! command -v avdmanager &> /dev/null; then
        echo -e "${RED}avdmanager not found in PATH. Please ensure Android SDK is properly installed.${NC}"
        exit 1
    fi
}

# List all installed emulators
list_emulators() {
    echo "=== AVAILABLE EMULATORS ==="
    if command -v avdmanager &> /dev/null; then
        # Parse and format avdmanager output for better readability
        avdmanager list avd | awk '
            BEGIN { print ""; }
            /Name:/ { printf "📱 %s\n", $2; }
            /Device:/ { printf "   Device: %s\n", substr($0, index($0,$2)); }
            /Path:/ { printf "   Path: %s\n", $2; }
            /Target:/ { printf "   Target: %s\n", substr($0, index($0,$2)); }
            /Based on:/ { printf "   Based on: %s\n\n", substr($0, index($0,$3)); }
        '
    else
        echo "avdmanager not found. Cannot list AVDs."
    fi
}

# List connected devices
list_devices() {
    echo "=== CONNECTED DEVICES ==="
    if command -v adb &> /dev/null; then
        # Get device list and format it
        local devices=$(adb devices)
        if [[ $(echo "$devices" | wc -l) -gt 1 ]]; then
            echo "$devices" | tail -n +2 | while read -r line; do
                if [[ ! -z "$line" ]]; then
                    local device_id=$(echo "$line" | awk '{print $1}')
                    local status=$(echo "$line" | awk '{print $2}')
                    local model=$(adb -s "$device_id" shell getprop ro.product.model 2>/dev/null | tr -d '\r')
                    local version=$(adb -s "$device_id" shell getprop ro.build.version.release 2>/dev/null | tr -d '\r')
                    
                    echo "🔌 Device: $device_id"
                    echo "   Status: $status"
                    if [[ ! -z "$model" ]]; then
                        echo "   Model: $model"
                    fi
                    if [[ ! -z "$version" ]]; then
                        echo "   Android: $version"
                    fi
                    echo ""
                fi
            done
        else
            echo "No devices connected"
        fi
    else
        echo "ADB not found. Cannot list devices."
    fi
    
    # Also show Flutter's device list
    if command -v flutter &> /dev/null; then
        echo -e "\n=== FLUTTER DEVICES ==="
        flutter devices
    fi
}

# Fix permissions for Android SDK
fix_permissions() {
    echo -e "${BLUE}Fixing permissions for Android SDK...${NC}"
    sudo chown -R $USER:$USER $ANDROID_HOME
    chmod -R u+rwX $ANDROID_HOME
    echo -e "${GREEN}Permissions fixed!${NC}"
}

# List and install system images
manage_system_images() {
    local options=("List available system images" "Install a system image" "Remove all system images" "Back")
    local choice=$(printf "%s\n" "${options[@]}" | rofi -dmenu -p "System Images:")
    
    case "$choice" in
        "List available system images")
            sdkmanager --list | grep "system-images" > /tmp/system_images.txt
            rofi -e "$(cat /tmp/system_images.txt)" -width -100
            ;;
        "Install a system image")
            local target=$(sdkmanager --list | grep "system-images" | awk '{print $1}' | rofi -dmenu -p "Select system image:")
            if [ -n "$target" ]; then
                alacritty -e bash -c "sdkmanager '$target'; echo 'Press Enter to continue...'; read"
                echo -e "${GREEN}System image installed: $target${NC}"
            fi
            ;;
        "Remove all system images")
            alacritty -e bash -c "rm -rf $ANDROID_HOME/system-images; echo 'All system images removed. Press Enter to continue...'; read"
            echo -e "${GREEN}All system images removed!${NC}"
            ;;
        "Back" | *)
            return
            ;;
    esac
}

# Create a new emulator
create_emulator() {
    # Get a list of available system images
    local available_images=$(sdkmanager --list | grep "system-images" | awk '{print $1}')
    
    if [ -z "$available_images" ]; then
        rofi -e "No system images found. Please install a system image first."
        return
    fi
    
    # Select a system image
    local selected_image=$(echo "$available_images" | rofi -dmenu -p "Select system image:")
    
    if [ -z "$selected_image" ]; then
        echo -e "${YELLOW}No system image selected. Aborting.${NC}"
        return
    fi
    
    # Get emulator name
    local emulator_name=$(rofi -dmenu -p "Enter emulator name:")
    
    if [ -z "$emulator_name" ]; then
        echo -e "${YELLOW}No name provided. Aborting.${NC}"
        return
    fi
    
    # Create the emulator
    echo -e "${BLUE}Creating emulator '$emulator_name' with image '$selected_image'...${NC}"
    alacritty -e bash -c "avdmanager create avd -n $emulator_name -k \"$selected_image\"; echo 'Press Enter to continue...'; read"
    echo -e "${GREEN}Emulator created!${NC}"
}

# Launch an emulator
launch_emulator() {
    # Get list of available emulators
    local emulators=$(avdmanager list avd | grep "Name:" | sed 's/Name: //')
    
    if [ -z "$emulators" ]; then
        rofi -e "No emulators found. Please create one first."
        return
    fi
    
    # Select an emulator
    local selected_emulator=$(echo "$emulators" | rofi -dmenu -p "Select emulator to launch:")
    
    if [ -z "$selected_emulator" ]; then
        echo -e "${YELLOW}No emulator selected. Aborting.${NC}"
        return
    fi
    
    # Launch options
    local launch_options=("Flutter emulator" "Direct Android emulator" "Back")
    local launch_method=$(printf "%s\n" "${launch_options[@]}" | rofi -dmenu -p "Launch method:")
    
    case "$launch_method" in
        "Flutter emulator")
            echo -e "${BLUE}Launching emulator '$selected_emulator' with Flutter...${NC}"
            flutter emulators --launch "$selected_emulator" &
            ;;
        "Direct Android emulator")
            echo -e "${BLUE}Launching emulator '$selected_emulator' directly...${NC}"
            emulator -avd "$selected_emulator" &
            ;;
        "Back" | *)
            return
            ;;
    esac
    
    echo -e "${GREEN}Emulator launch initiated!${NC}"
}

# Delete an emulator
delete_emulator() {
    # Get list of available emulators
    local emulators=$(avdmanager list avd | grep "Name:" | sed 's/Name: //')
    
    if [ -z "$emulators" ]; then
        rofi -e "No emulators found to delete."
        return
    fi
    
    # Select an emulator to delete
    local selected_emulator=$(echo "$emulators" | rofi -dmenu -p "Select emulator to delete:")
    
    if [ -z "$selected_emulator" ]; then
        echo -e "${YELLOW}No emulator selected. Aborting.${NC}"
        return
    fi
    
    # Confirm deletion
    local confirm=$(printf "Yes\nNo" | rofi -dmenu -p "Are you sure you want to delete '$selected_emulator'?")
    
    if [ "$confirm" = "Yes" ]; then
        echo -e "${BLUE}Deleting emulator '$selected_emulator'...${NC}"
        alacritty -e bash -c "avdmanager delete avd -n \"$selected_emulator\"; echo 'Press Enter to continue...'; read"
        echo -e "${GREEN}Emulator deleted!${NC}"
    else
        echo -e "${YELLOW}Deletion cancelled.${NC}"
    fi
}

# Clean up broken emulators
clean_emulators() {
    local confirm=$(printf "Yes\nNo" | rofi -dmenu -p "This will delete all emulator files. Are you sure?")
    
    if [ "$confirm" = "Yes" ]; then
        echo -e "${BLUE}Cleaning up all emulator files...${NC}"
        alacritty -e bash -c "rm -rf ~/.android/avd/*; echo 'Press Enter to continue...'; read"
        echo -e "${GREEN}All emulator files cleaned!${NC}"
    else
        echo -e "${YELLOW}Cleanup cancelled.${NC}"
    fi
}

# Main menu
main_menu() {
    local options=(
        "List all emulators"
        "List connected devices"
        "Create new emulator"
        "Launch emulator"
        "Delete emulator"
        "Manage system images"
        "Fix SDK permissions"
        "Clean all emulator files"
        "Exit"
    )
    
    while true; do
        local choice=$(printf "%s\n" "${options[@]}" | rofi -dmenu -p "Flutter AVD Manager:")
        
        case "$choice" in
            "List all emulators")
                list_output=$(list_emulators)
                rofi -e "$list_output" -width 80 -lines 20
                ;;
            "List connected devices")
                devices_output=$(list_devices)
                rofi -e "$devices_output" -width 80 -lines 20
                ;;
            "Create new emulator")
                create_emulator
                ;;
            "Launch emulator")
                launch_emulator
                ;;
            "Delete emulator")
                delete_emulator
                ;;
            "Manage system images")
                manage_system_images
                ;;
            "Fix SDK permissions")
                alacritty -e bash -c "$(declare -f fix_permissions); fix_permissions; echo 'Press Enter to continue...'; read"
                ;;
            "Clean all emulator files")
                clean_emulators
                ;;
            "Exit" | *)
                echo -e "${GREEN}Goodbye!${NC}"
                break
                ;;
        esac
    done
}

# Setup environment before running
setup_environment

# Start the main menu
main_menu

