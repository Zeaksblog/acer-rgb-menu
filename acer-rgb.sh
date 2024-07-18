#!/bin/bash

CONFIG_DIR="$HOME/.config/predator/saved profiles"

# Ensure the config directory exists
mkdir -p "$CONFIG_DIR"

# Function to display ASCII banner
show_banner() {
    echo "    / \   ___ ___ _ __  |  _ \ / ___| __ )   / ___|___  _ __ | |_ _ __ ___ | |"
    echo "   / _ \ / __/ _ \ '__| | |_) | |  _|  _ \  | |   / _ \| '_ \| __| '__/ _ \| |"
    echo "  / ___ \ (_|  __/ |    |  _ <| |_| | |_) | | |__| (_) | | | | |_| | | (_) | |"
    echo " /_/   \_\___\___|_|    |_| \_\\____|____/   \____\___/|_| |_|\__|_|  \___/|_|"
    echo
}

# Function to list saved profiles
list_profiles() {
    if [ -d "$CONFIG_DIR" ]; then
        echo "Saved profiles:"
        profiles=($(ls "$CONFIG_DIR"))
        if [ ${#profiles[@]} -eq 0 ]; then
            echo "No profiles found."
            exit 0
        fi
        for i in "${!profiles[@]}"; do
            echo "$((i+1)) - ${profiles[i]%.json}"
        done
    else
        echo "No profiles found."
        exit 0
    fi
}

# Function to load a profile
load_profile() {
    PROFILE_PATH="$CONFIG_DIR/$1.json"
    if [ -f "$PROFILE_PATH" ]; then
        ./facer_rgb.py -load "$1"
        post_action_menu
    else
        echo "Profile '$1' not found."
        exit 1
    fi
}

# Function to save the current settings to a profile using the program's -save command
save_profile() {
    PROFILE_NAME="$1"
    cmd="./facer_rgb.py -save \"$PROFILE_NAME\""
    eval $cmd
}

# Function to show main menu
show_main_menu() {
    echo "Choose an option:"
    echo "  1 -> Create New Profile"
    echo "  2 -> List Saved Profiles"
    read -p "Enter your choice [1-2]: " MAIN_OPTION

    case $MAIN_OPTION in
        1) return 0 ;; # Continue to create new profile
        2) list_profiles
           read -p "Enter the number of the profile to load: " PROFILE_NUMBER
           profiles=($(ls "$CONFIG_DIR"))
           load_profile "${profiles[$((PROFILE_NUMBER-1))]%.json}"
           ;;
        *) echo "Invalid option. Exiting."; exit 1 ;;
    esac
}

# Function to show menu and read user input
show_menu() {
    echo "Choose an effect mode:"
    echo "  0 -> Static"
    echo "  1 -> Breath"
    echo "  2 -> Neon"
    echo "  3 -> Wave"
    echo "  4 -> Shifting"
    echo "  5 -> Zoom"
    read -p "Enter your choice [0-5]: " MODE

    case $MODE in
        0) mode="static"
           echo "Static mode options:"
           echo "  1 -> Single Zone"
           echo "  2 -> All Zones"
           read -p "Choose an option [1-2]: " STATIC_OPTION
           if [ "$STATIC_OPTION" -eq 1 ]; then
               read -p "Enter Zone ID [1-4]: " ZONE
               read -p "Enter RGB color [1 -> Red, 2 -> Blue, 3 -> Green]: " COLOR
               case $COLOR in
                   1) cR=255; cG=0; cB=0 ;;
                   2) cR=0; cG=0; cB=255 ;;
                   3) cR=0; cG=255; cB=0 ;;
                   *) echo "Invalid color choice. Exiting."; exit 1 ;;
               esac
           elif [ "$STATIC_OPTION" -eq 2 ]; then
               read -p "Enter RGB color for all zones [1 -> Red, 2 -> Blue, 3 -> Green]: " COLOR
               case $COLOR in
                   1) cR=255; cG=0; cB=0 ;;
                   2) cR=0; cG=0; cB=255 ;;
                   3) cR=0; cG=255; cB=0 ;;
                   *) echo "Invalid color choice. Exiting."; exit 1 ;;
               esac
           else
               echo "Invalid option. Exiting."; exit 1
           fi
           ;;
        1) mode="breath"
           read -p "Enter RGB color [1 -> Red, 2 -> Blue, 3 -> Green]: " COLOR
           case $COLOR in
               1) cR=255; cG=0; cB=0 ;;
               2) cR=0; cG=0; cB=255 ;;
               3) cR=0; cG=255; cB=0 ;;
               *) echo "Invalid color choice. Exiting."; exit 1 ;;
           esac
           ;;
        2) mode="neon" ;;
        3) mode="wave"
           read -p "Enter animation speed [1-9]: " SPEED ;;
        4) mode="shifting"
           read -p "Enter RGB color [1 -> Red, 2 -> Blue, 3 -> Green]: " COLOR
           case $COLOR in
               1) cR=255; cG=0; cB=0 ;;
               2) cR=0; cG=0; cB=255 ;;
               3) cR=0; cG=255; cB=0 ;;
               *) echo "Invalid color choice. Exiting."; exit 1 ;;
           esac
           read -p "Enter animation speed [1-9]: " SPEED ;;
        5) mode="zoom"
           read -p "Enter RGB color [1 -> Red, 2 -> Blue, 3 -> Green]: " COLOR
           case $COLOR in
               1) cR=255; cG=0; cB=0 ;;
               2) cR=0; cG=0; cB=255 ;;
               3) cR=0; cG=255; cB=0 ;;
               *) echo "Invalid color choice. Exiting."; exit 1 ;;
           esac
           read -p "Enter animation speed [1-9]: " SPEED ;;
        *) echo "Invalid mode choice. Exiting."; exit 1 ;;
    esac
}

# Function to ask if user wants to return to main menu or exit
post_action_menu() {
    while true; do
        read -p "Do you want to return to the main menu or exit? [m/e]: " CHOICE
        case $CHOICE in
            m) show_main_menu; show_menu ;;
            e) exit ;;
            *) echo "Invalid choice. Please enter 'm' to return to the main menu or 'e' to exit." ;;
        esac
    done
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -list)
            list_profiles
            exit 0
            ;;
        -load)
            load_profile "$2"
            shift # past argument
            shift # past value
            ;;
        -save)
            SAVE_PROFILE="$2"
            shift # past argument
            shift # past value
            ;;
        -h|--help)
            echo "Usage: $0 [-h] [-list] [-load PROFILE_NAME] [-save PROFILE_NAME]"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Usage: $0 [-h] [-list] [-load PROFILE_NAME] [-save PROFILE_NAME]"
            exit 1
            ;;
    esac
done

# Main logic
show_banner
show_main_menu
show_menu

# Construct and execute the command(s) with the chosen options
cmd="./facer_rgb.py -m $MODE"
if [ "$MODE" -eq 0 ] && [ "$STATIC_OPTION" -eq 2 ]; then
    for ZONE in {1..4}; do
        cmd="./facer_rgb.py -m $MODE -z $ZONE -cR $cR -cG $cG -cB $cB"
        eval $cmd
    done
else
    if [ "$MODE" -eq 0 ] && [ "$STATIC_OPTION" -eq 1 ]; then
        cmd="$cmd -z $ZONE -cR $cR -cG $cG -cB $cB"
    else
        case $MODE in
            1|4|5) cmd="$cmd -cR $cR -cG $cG -cB $cB" ;;
        esac
        if [[ "$MODE" -eq 3 || "$MODE" -eq 4 || "$MODE" -eq 5 ]]; then
            cmd="$cmd -s $SPEED"
        fi
    fi
    eval $cmd
fi

# Ask if the user wants to save the profile
read -p "Save as new profile? (y/n): " SAVE_OPTION
if [[ "$SAVE_OPTION" =~ ^[Yy]$ ]]; then
    read -p "Enter profile name: " PROFILE_NAME
    save_profile "$PROFILE_NAME"
fi

# After action, ask user to return to main menu or exit
post_action_menu

echo "Command executed successfully."

