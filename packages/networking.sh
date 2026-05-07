#!/bin/bash

GREEN="\e[32m"
RED="\e[31m"
BLUE="\e[34m"
YELLOW="\e[33m"
RESET="\e[0m"

packages=(
	nmap
	tcpdump
	traceroute
	dig
	iperf3
)

for pkg in "${packages[@]}"
do
    sudo dnf install -y "$pkg" > /dev/null 2>&1

    if command -v "$pkg" > /dev/null 2>&1; then
        echo -e "${GREEN}[✓] ${pkg} installed${RESET}"
    else
        echo -e "${RED}[✗] Failed to install ${pkg}${RESET}"
    fi

done

