#!/usr/bin/env bash

show() {
 printf  "$1\n"
}

show_status() {
GREEN=$(tput setaf 2)
NORMAL=$(tput sgr0)
if [ $2 == 0 ]; then
status=$GREEN[OK]
else
status=[KO]
fi
line='..................................................................................'
txt=$1
printf "%s %s %s\n" "$NORMAL$txt" "${line:${#txt}}" "$status"

}
