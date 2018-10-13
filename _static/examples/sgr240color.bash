#!/bin/bash

# SGR (select graphic rendition) escape sequence
sgr() {
    echo -ne "\033[$1m"
}

print_swatch() {
    start=$1
    end=$(( $start + 7 ))
    sgr 0
    printf "%-4d" $start

    for i in $(seq $start $end); do
        sgr "48;5;$i"
        echo -n "         "
    done
    echo
}

echo "Additional Colors:"
echo "    +0       +1       +2       +3       +4       +5       +6       +7"

for row in $(seq 2 31); do
    print_swatch $(( $row * 8 ))
done
echo
