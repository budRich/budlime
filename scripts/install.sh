#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BUD_DIR="${THIS_DIR}/.."
SUB_DIR="$HOME/.config/sublime-text-3"
PKG_DIR="$SUB_DIR/Packages"
USR_DIR="$PKG_DIR/User"

# make bu of package dir
BU_DIR="$SUB_DIR/backup/$(cat /proc/sys/kernel/random/uuid)"

killall sublime_text

[[ -d $PKG_DIR ]] && {
	mkdir -p "$BU_DIR"
	mv -f "$PKG_DIR" "$BU_DIR"
}

rm -f "${SUB_DIR}/Local/*.sublime_session"

# copy User/Package Control.subset
mkdir -p "${USR_DIR}"
cp "${BUD_DIR}/packages/Package Control/Package Control.sublime-settings" \
   "${USR_DIR}"

# subl -w + dunstify
dunstify -r 112 -t 0 "Select 'Install Package Control', from 'Tools' menu."
dunstify -r 111 -u critical "Close sublime window when all packages are installed..."
subl "${SUB_DIR}/Installed Packages"
subl -w "${USR_DIR}/Package Control.sublime-settings"
dunstify -C 111
dunstify -C 112

# extract packages
subextract -ced -p "${BUD_DIR}/packages"

rm -f "${SUB_DIR}/Local/*.sublime_session"

# open sublime with sublime project
subl "${USR_DIR}/Projects/sublime.sublime-project"
