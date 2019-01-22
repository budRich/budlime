#!/usr/bin/env bash

loopsource(){
  # _cnfext="sublime-settings"
  # move settings to usr dir
  for f in "$1"/*; do
    [[ -d "$f" ]] && loopsource "$f" && continue
    [[ ${f,,} =~ readme.md$ ]] && continue
    dirname="${f#${__o[packages]}\/}"
    dirname="${dirname%/*}"
    lastdir="${dirname##*/}"

    if [[ $f =~ ${_cnfext}$ ]] && [[ $lastdir != zublime ]]; then
      ((__o[force]=1)) \
        && cp -f "$f" "$_usrdir" && continue \
        || cp "$f" "$_usrdir" && continue
    else
      mkdir -p "${_pkgdir}/$dirname"
      ((__o[force]=1)) \
        && cp -f "$f" "${_pkgdir}/$dirname" \
        || cp "$f" "${_pkgdir}/$dirname"
    fi
  done
}
