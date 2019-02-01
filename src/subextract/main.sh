#!/usr/bin/env bash

main(){

  _sub_dir="$HOME/.config/sublime-text-3"
  _tmp_dir="/tmp/subextract"
  _zip_dir="$_sub_dir/Installed Packages"
  _pkg_dir="$_sub_dir/Packages"
  _usr_dir="$_pkg_dir/User"
  _doc_dir="$_usr_dir/dox"

  _pkg_ext="sublime-package"
  _cnf_ext="sublime-settings"


  ((${__o[clean]:-0}==1)) && {
    _bu_dir="$_sub_dir/backup/$(cat /proc/sys/kernel/random/uuid)"
    mkdir -p "$_bu_dir"
    [[ -d $_pkg_dir ]] && mv -f "$_pkg_dir" "$_bu_dir"
  }

  [[ -d ${__o[sync]:-} ]] && ((${__o[extract]:-0}!=1)) \
    && synksettings "${__o[sync]%/}"
  
  if ((${__o[extract]:-0}==1)); then

    extractinstalled

    [[ -d ${__o[sync]:-} ]] && synksettings "${__o[sync]%/}"

    rm -rf "${_tmp_dir:?}"
  fi
  
}

___source="$(readlink -f "${BASH_SOURCE[0]}")"  #bashbud
___dir="${___source%/*}"                        #bashbud
source "$___dir/init.sh"                        #bashbud
main "${@}"                                     #bashbud
