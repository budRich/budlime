#!/usr/bin/env bash

extractinstalled(){
  for p in "$_zipdir/"*."${_pkgext}"; do
    
    echo "$p"

    name="${p##*/}"
    name="${name%.*}"

    keys=""
    conf=""
    reads=""
    cmds=""

    eval "$(unzip -l "$p" -x */* -x *.{todo,tmLanguage,tmPreferences,ini,mustache,ico,xml,disabled-sublime-syntax,bin,dictonary,sublimelinterrc,txt,py,gitignore,json,exe,cs,png,cur,resx,cpp,m,csproj,snk,pal,aco,gpl,sln,sh,css,html,log,ss,dockerignore,yml,svg,js,cfg} \
      | awk '{$1=$2=$3="";sub(/[[:space:]]*/,"",$0)
        if(/./ && $0 != "Name" && $0 != "----") {
          if (/sublime-settings$/) print "conf=\"" $0 "\""
          if (/sublime-commands$/) print "cmds=\"" $0 "\""
          if (/Default( [(]Linux[)])*.sublime-keymap$/) print "keys=\"" $0 "\""
          if (tolower($0) == "readme.md") print "reads=\"" $0 "\""
        }}')"

    (
      cd "${_tmpdir}" || exit 1
      # unzip "$p" -d . "${reads}" "${conf}" "${keys}" > /dev/null 2>&1
      unzip "$p" -d . "${reads}" "${conf}" "${keys}" "${cmds}"

      trgread="${_docdir}/packages/$name.md"
      [[ -f $reads ]] && [[ ! -f $trgread ]] \
        && mv "$reads" "$trgread"
        
      [[ -f $keys ]] && {
        mv "$keys" "${_defdir}/$name.keymap"
        ((__o[extract]==1)) && [[ ! -f "${_pkgdir}/$name/${keys##*/}" ]] && {
          mkdir -p "${_pkgdir}/$name"
          cp "${_defdir}/$name.keymap" "${_pkgdir}/$name/${keys##*/}"
        }
      }

      [[ -f $conf ]] && {
        cnfname="${conf##*/}"
        cnfname="${cnfname%.*}"
        [[ $name != "Package Control" ]] && [[ ${conf##*/} != Preferences.${_cnfext} ]] && {
          [[ -f "${_usrdir}/${conf##*/}" ]] || cp "$conf" "${_usrdir}"
          ((__o[extract]==1)) && {
            mkdir -p "${_pkgdir}/$name"
            ((__o[blank]==1)) \
              && echo "{}" > "${_pkgdir}/$name/${conf##*/}" \
              || cp "${conf}" "${_pkgdir}/$name/${conf##*/}"
          }
        }

        [[ ${conf##*/} = Preferences.${_cnfext} ]] \
          && mv "$conf" "${_defdir}/$name.${_cnfext#sublime-}" \
          || mv "$conf" "${_defdir}/$cnfname.${_cnfext#sublime-}"
      }

      [[ -f $cmds ]] && {
        echo "$cmds"
        mv "$cmds" "${_defdir}/$name.commands"
        ((__o[extract]==1)) && [[ ! -f "${_pkgdir}/$name/${cmds##*/}" ]] && {
          mkdir -p "${_pkgdir}/$name"
          cp "${_defdir}/$name.commands" "${_pkgdir}/$name/${cmds##*/}"
        }
      }

      rm -rf ./*
    )

  done
}
