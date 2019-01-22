#!/usr/bin/env bash

extractdefaults(){
    p="$_optdir/Default.sublime-package"
    afil=()
    eval "$(unzip -l "$p" -x */* -x *.{todo,tmLanguage,tmPreferences,ini,mustache,ico,xml,disabled-sublime-syntax,bin,dictonary,sublimelinterrc,txt,py,gitignore,json,exe,cs,png,cur,resx,cpp,m,csproj,snk,pal,aco,gpl,sln,sh,css,html,log,ss,dockerignore,yml,svg,js,cfg} \
      | awk '{$1=$2=$3="";sub(/[[:space:]]*/,"",$0)
        if(/./ && $0 != "Name" && $0 != "----") {
          # if (/settings/) print "afil+=(\"" $0 "\")"
          if (/sublime-commands$/) print "afil+=(\"" $0 "\")"
          if (/Preferences( [(]Linux[)])*.sublime-settings$/) print "afil+=(\"" $0 "\")"
          if (/Default( [(]Linux[)])*.sublime-keymap$/) print "afil+=(\"" $0 "\")"
          if (/Default( [(]Linux[)])*.sublime-mousemap$/) print "afil+=(\"" $0 "\")"
        }}')"


    rm -rf "${_tmpdir:?}"/*
    

    unzip "$p" -d "${_tmpdir}" "${afil[@]}"

    # copy stuff to defdir
    dprefs=(
      "${_tmpdir}/Preferences.sublime-settings"
      "${_tmpdir}/Preferences (Linux).sublime-settings"
    )

    dkeys=(
      "${_tmpdir}/Default (Linux).sublime-keymap"
      "${_tmpdir}/Default (Linux).sublime-mousemap"
    )

    dcmds=(
      "${_tmpdir}/Default.sublime-commands"
    )




    for d in "${dprefs[@]}" "${dkeys[@]}" "${dcmds[@]}"; do
      dnmn="${d##*/}"
      cp -f "$d" "${_defdir}/${dnmn/sublime-/}"
    done

    ((__o[extract]==1)) && {
      mkdir -p "${_pkgdir}/zublime" "${_pkgdir}/Default"
      # move default settings to zublime
      [[ -f ${_pkgdir}/zublime/Preferences.sublime-settings ]] || awk '
        BEGIN{fndblk=0}

        /^[}]/ {exit}
        start==1 && /./ {blk[fndblk]=blk[fndblk] "\n" $0}
        start==1 && $0 !~ /./ {fndblk++}
        $1 ~ "font_options|theme_font_options|color_scheme|font_face|font_size|ignored_packages" {ignore[fndblk]=1}
        /^[{]/ {start=1}

        END{
          print "{"
          for (b in blk){
            keep=1
            for (i in ignore) {
              if (i==b){keep=0}
            }
            if (keep==1)print blk[b]
          }
          print "}"
        }
      ' "${_tmpdir}/Preferences.sublime-settings" > "${_pkgdir}/zublime/Preferences.sublime-settings"

      # move default settings to user (autofile)
      [[ -f ${_usrdir}/Preferences.sublime-settings ]] || awk '
        BEGIN{fndblk=0}

        /^[}]/ {exit}
        start==1 && /./ {blk[fndblk]=blk[fndblk] "\n" $0}
        start==1 && $0 !~ /./ {fndblk++}
        $1 ~ "font_options|theme_font_options|color_scheme|font_face|font_size|ignored_packages" {ignore[fndblk]=1}
        /^[{]/ {start=1}

        END{
          print "{"
          for (b in blk){
            keep=1
            for (i in ignore) {
              if (i==b){keep=0}
            }
            if (keep==0)print blk[b]
          }
          print "}"
        }
      ' "${_tmpdir}/Preferences.sublime-settings" > "${_usrdir}/Preferences.sublime-settings"

      rm -f "${dprefs[@]}"


      ((__o[blank]==1)) \
          && echo "{}" | tee "${dprefs[@]}"

      mkdir -p "${_pkgdir}/Default"
      
      for f in "${dprefs[@]}" "${dkeys[@]}" "${dcmds[@]}"; do
        [[ -f "${_pkgdir}/Default/${f##*/}" ]] || mv "$f" "${_pkgdir}/Default"
      done
    }
    
    rm -rf "${_tmpdir:?}"/*
}
