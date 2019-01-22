#!/usr/bin/env bash

synksettings(){
  [[ -d "$1" ]] || exit 1

  for f in "$1"/*; do
    [[ -d "$f" ]] && synksettings "$f" && continue
    [[ ${f,,} =~ readme.md$ ]] && continue
    dirname="${f#${__o[packages]}\/}"
    dirname="${dirname%/*}"
    lastdir="${dirname##*/}"

    { [[ $f =~ ${_cnfext}$ ]] && [[ $lastdir != zublime ]] ;} \
      && f2="${_usrdir}/${f##*/}" \
      || f2="${_pkgdir}/$dirname/${f##*/}"

    if ((__o[force]=1)) && [[ -f "${f2}" ]] && [[ "${f}" -ot "${f2}" ]]; then
      printf '%s --> %s\n' "${f2}" "${f}"
      cp -f "${f2}" "${f}"
    else
      printf '%s --> %s\n' "${f}" "${f2}"
      cp -f "${f}" "${f2}"
    fi

  done
}
