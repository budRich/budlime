#!/usr/bin/env bash

synksettings(){

  local trgdir="$1"
  local file1 file2 nmn dirname lastdir nmn2

  [[ -d $trgdir ]] || exit 1

  OFS="${IFS}"
  IFS=$'\n'
  while read -r file1; do
    # ignore redme files
    [[ ${file1,,} =~ readme[.]md$ ]] && continue
    nmn="${file1#${trgdir}/}"
    dirname="${nmn%/*}"
    lastdir="${dirname##*/}"

    if [[ $file1 =~ ${_cnf_ext}$ ]] && [[ $lastdir != zublime ]]; then
      file2="${_usr_dir}/${file1##*/}"
    else
      file2="${_pkg_dir}/$dirname/${file1##*/}"
    fi

    # copy file from sublime to budlime
    # only if --force is not set
    if ((${__o[force]:-0}!=1)) && [[ -f "${file2}" ]] && [[ "${file1}" -ot "${file2}" ]]; then
      ((${__o[quite]:-0}!=1)) && {
        nmn2="${file2%${nmn##*/}}"
        nmn2="${nmn2#${_sub_dir}}"

        if [[ -L $file2 ]]; then
          printf '%-60s L== %s\n' "$nmn" "$nmn2"
        else
          printf '%-60s <== %s\n' "$nmn" "$nmn2"
        fi
      } >&2 
        
      [[ -L $file2 ]] || cp -f "${file2}" "${file1}"

    # copy file from budlime to sublime
    else
      ((${__o[quite]:-0}!=1)) && {
        nmn2="${file2%${nmn##*/}}"
        nmn2="${nmn2#${_sub_dir}}"
        
        if [[ -L $file2 ]]; then
          printf '%-60s ==L %s\n' "$nmn" "$nmn2"
        elif ((${__o[force]:-0}==1)) || [[ ! -f ${file2} ]]; then
          printf '%-60s ==> %s\n' "$nmn" "$nmn2"
          mkdir -p "${file2%/*}"
        else
          printf '%-60s ==| %s\n' "$nmn" "$nmn2"
        fi
      } >&2

      if [[ -L $file2 ]]; then
        :
      elif ((${__o[force]:-0}==1)); then
        cp -f "${file1}" "${file2}"
      elif [[ ! -f ${file2} ]]; then
        cp "${file1}" "${file2}"
      fi
    fi

  done <<< "$(find "$trgdir" -type f)"
  IFS="${OFS}"

}
