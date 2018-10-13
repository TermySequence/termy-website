#!/bin/bash

# SGR (select graphic rendition) escape sequence
sgr() {
    echo -ne "\033[$1m"
}

check_input() {
    if [ "$1" -ge 0 -a "$1" -le 255 ]; then return; fi
    echo Wrong. 1>&2
    exit 1
}

read -p "Enter red component (0-255): " red
check_input $red
read -p "Enter blue component (0-255): " blue
check_input $blue
read -p "Enter green component (0-255): " green
check_input $green

sgr "48;2;$red;$green;$blue"
echo "                                        "
echo "                                        "
echo "                                        "
echo "                                        "
sgr 0
