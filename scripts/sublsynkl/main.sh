#!/usr/bin/env bash

main(){

  # globals
  _tmpdir="/tmp/subextract"
  _zipdir="$SUBLIME_DIR/Installed Packages"
  _pkgdir="$SUBLIME_DIR/Packages"
  _usrdir="$_pkgdir/User"
  _docdir="$_usrdir/dox"
  _defdir="$_docdir/defaults"
  _optdir="${SUBLIME_SRC}/Packages"
  _gitdir="$HOME/git/dox"
  _pkgext="sublime-package"
  _cnfext="sublime-settings"
  _optdir="${SUBLIME_SRC}/Packages"



  ((__o[clean]==1)) && {
    _budir="$SUBLIME_DIR/backup/$(cat /proc/sys/kernel/random/uuid)"
    mkdir -p "$_budir"
    [[ -d $_pkgdir ]] && mv -f "$_pkgdir" "$_budir"
  }

  mkdir -p "${_tmpdir}" "${_usrdir}/Projects" "${_defdir}" \
           "${_docdir}/packages" "${_pkgdir}" "${_gitdir}"

  [[ -d ${__o[pacakages]} ]] && loopsource "${__o[pacakages]}"
  
  extractinstalled
  extractdefaults

  # remove _tmpdir
  rm -rf "${_tmpdir:?}"
  
}

___source="$(readlink -f "${BASH_SOURCE[0]}")"  #bashbud
___dir="${___source%/*}"                        #bashbud
source "$___dir/init.sh"                        #bashbud
main "${@}"                                     #bashbud
