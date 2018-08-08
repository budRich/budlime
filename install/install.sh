#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BUD_DIR="${THIS_DIR}/.."
SUB_DIR="$HOME/.config/sublime-text-3"
PKG_DIR="$SUB_DIR/Packages"
USR_DIR="$PKG_DIR/User"


killall sublime_text

# make bu of package dir
BU_DIR="$SUB_DIR/backup/$(cat /proc/sys/kernel/random/uuid)"

[[ -d $PKG_DIR ]] && {
  mkdir -p "$BU_DIR"
  mv -f "$PKG_DIR" "$BU_DIR"
  rm -rf "$PKG_DIR"
}

rm -f "${SUB_DIR}/Local/"*.sublime_session
rm -rf "${SUB_DIR}/Cache"

# prepare sublime for install
mkdir -p "${PKG_DIR}/mondo"
mkdir -p "${USR_DIR}"
cp -f "${BUD_DIR}/packages/Package Control/Package Control.sublime-settings" \
   "${USR_DIR}"
cp -f "${BUD_DIR}/packages/mondo/mondo.tmTheme" \
	"${PKG_DIR}/mondo"
cp -f "${THIS_DIR}/Preferences.sublime-settings" \
	"${USR_DIR}"

dunstify -r 112 -t 0 "Select 'Install Package Control', from 'Tools' menu."
dunstify -r 111 -u critical "Close sublime window when all packages are installed..."
subl "${THIS_DIR}/install.sublime-workspace"
subl -w "${USR_DIR}/Package Control.sublime-settings"
dunstify -C 111
dunstify -C 112

rm -f \
  "${USR_DIR}/Preferences.sublime-settings" \
  "${USR_DIR}/ApplySyntax"*

# extract packages
"${BUD_DIR}/scripts/subextract/"subextract.sh -ed -p "${BUD_DIR}/packages"

rm -f "${SUB_DIR}/Local/"*.sublime_session

# open sublime with sublime project
subl "${USR_DIR}/Projects/sublime.sublime-project"
