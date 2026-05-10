#!/bin/bash

GREEN="\e[32m"
RED="\e[31m"
BLUE="\e[34m"
YELLOW="\e[33m"
RESET="\e[0m"

packages=(
    htop
    btop
    iftop
    iotop
    [sysstat]="sar"
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

sudo dnf install -y cockpit > /dev/null 2>&1

if rpm -q cockpit > /dev/null 2>&1; then
    echo -e "${GREEN}[✓] cockpit installed${RESET}"

    sudo systemctl enable --now cockpit.socket > /dev/null 2>&1

    if systemctl is-active --quiet cockpit.socket; then
        echo -e "${GREEN}[✓] cockpit service enabled${RESET}"

        IP=$(hostname -I | awk '{print $1}')

        echo ""
        echo -e "${CYAN}Cockpit Web Interface:${RESET}"
        echo -e "${CYAN}→ https://localhost:9090${RESET}"
        echo -e "${CYAN}→ https://${IP}:9090${RESET}"
    else
        echo -e "${RED}[✗] Failed to start cockpit service${RESET}"
    fi

else
    echo -e "${RED}[✗] Failed to install cockpit${RESET}"
fi
