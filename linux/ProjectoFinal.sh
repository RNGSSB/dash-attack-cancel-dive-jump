#!/bin/sh
echo -ne '\033c\033]0;ProjectoFinal\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/ProjectoFinal.x86_64" "$@"
