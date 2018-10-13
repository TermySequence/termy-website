#!/bin/bash

# SGR (select graphic rendition) escape sequence
sgr() {
    echo -ne "\033[$1m"
}

print_swatch() {
    for line in $(seq 1 $1); do
        for i in $(seq $3 $4); do
            sgr $i
            echo -n "$2"
        done
        echo
    done
}

sgr 0
echo
echo "Primary Colors:"
print_swatch 4 "●●●●●●●●●●" 30 37
print_swatch 4 "          " 40 47

sgr 0
echo
echo "Bright Colors:"
print_swatch 4 "●●●●●●●●●●" 90 97
print_swatch 4 "          " 100 107

echo
