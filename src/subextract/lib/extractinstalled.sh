#!/usr/bin/env bash

extractinstalled(){

  local file nmn xdir

  mkdir -p "$_tmp_dir"
  rm -rf "${_tmp_dir:?}/"*

  OFS="${IFS}"
  IFS=$'\n'

  # extract files
  while read -r file; do

    nmn="${file##*/}"
    nmn="${nmn%.*}"

    # ignore package control
    [[ $nmn =~ 0_package_control_loader|(Package Control) ]] && continue

    # only extract setting files, and ignore
    # subdirectories
    unzip -qq "$file" \
      "*.sublime-settings" \
      "Default.sublime-commands" \
      "Default (Linux).sublime-keymap" \
      "Default.sublime-keymap" \
      -x "*/*" \
      -d "$_tmp_dir/$nmn" > /dev/null 2>&1

  done <<< "$(
    # all installed archived packages
    find "$_zip_dir" -type f -name "*.${_pkg_ext}"
  )"

  # extract default package
  unzip -qq "/opt/sublime_text/Packages/Default.sublime-package" \
    "Distraction Free.sublime-settings" \
    "Preferences (Linux).sublime-settings" \
    "Preferences.sublime-settings" \
    "Default.sublime-commands" \
    "Default (Linux).sublime-keymap" \
    "Default.sublime-keymap" \
    -x "*/*" \
    -d "$_tmp_dir/Default" > /dev/null 2>&1

  # remove empty tmp dirs
  rmdir "${_tmp_dir}"/* > /dev/null 2>&1

  # copy files to sublime dir
  while read -r file; do

    nmn="${file#$_tmp_dir/}"
    nmn="${nmn%%/*}"

    xdir="$_pkg_dir/$nmn"

    # create xdir
    mkdir -p "$xdir"
    # create docdir
    mkdir -p "$_doc_dir/$nmn"

    # copy files to xdir
    if ((${__o[blank]:-0}==1)); then
      cp -f "$file" "$xdir"
    else
      cp "$file" "$xdir"
    fi
    cp -f "$file" "$_doc_dir/$nmn/${file##*/}X"

    if [[ $file = "*.sublime-settings" ]]; then
      if ((${__o[blank]:-0}==1)); then
        cp -f "$file" "$_usr_dir"
      else
        cp "$file" "$_usr_dir"
      fi
      
      ((${__o[blank]:-0}==1)) && {
        echo "[]" > "$file"
      }
    fi

  done <<< "$(find "$_tmp_dir" -type f)"

  IFS="${OFS}"
}
