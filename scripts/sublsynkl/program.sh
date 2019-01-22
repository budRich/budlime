#!/usr/bin/env bash

___printversion(){
  
cat << 'EOB' >&2
sublsynkl - version: 2019.01.18.10
updated: 2019-01-18 by budRich
EOB
}


# environment variables
: "${SUBLIME_DIR:=$XDG_CONFIG_HOME/sublime-text-3}"
: "${SUBLIME_SRC:=/opt/sublime_text}"


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

___printhelp(){
  
cat << 'EOB' >&2
sublsynkl - Creates a settings project as an alternative to the default sublime settings system.


SYNOPSIS
--------
sublsynkl --packages|-p PACKAGE_DIRECTORY [--clean|-c] [--blank|-d] [--extract|-e] [--force|-f] 
sublsynkl --sync|-s PACKAGE_DIRECTORY  [--force|-f]
sublsynkl --help|-h
sublsynkl --version|-v

OPTIONS
-------

--packages|-p PACKAGE_DIRECTORY  
Copy files withing PACKAGE_DIRECTORY before any
other operations.  



--clean|-c  
Clean install. Move the current
$SUBLIME_DIR/Packages to $SUBLIME_DIR/backup
before any other operations.  


--blank|-d  
Blank extracted default files. (only have effect
if --extract is used)


--extract|-e  
Extract packages default setting files to
$SUBLIME_DIR/Packages.


--force|-f  
Force files from PACKAGE_DIRECTORY to overwrite,
no matter if target file exists (when used with
--packages)  or is newer (when used with --sync).


--sync|-s PACKAGE_DIRECTORY  
Sync files in PACKAGE_DIRECTORY with files in
$SUBLIME_DIR/Packages. Works both ways, the newest
file will overwrite the oldest.


--help|-h  
Show help and exit.

--version|-v  
Show version and exit.

EOB
}


ERM(){ >&2 echo "$*"; }
ERR(){ >&2 echo "[WARNING]" "$*"; }
ERX(){ >&2 echo "[ERROR]" "$*" && exit 1 ; }

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
declare -A __o
eval set -- "$(getopt --name "sublsynkl" \
  --options "p:cdefs:hv" \
  --longoptions "packages:,clean,blank,extract,force,sync:,help,version," \
  -- "$@"
)"

while true; do
  case "$1" in
    --packages   | -p ) __o[packages]="${2:-}" ; shift ;;
    --clean      | -c ) __o[clean]=1 ;; 
    --blank      | -d ) __o[blank]=1 ;; 
    --extract    | -e ) __o[extract]=1 ;; 
    --force      | -f ) __o[force]=1 ;; 
    --sync       | -s ) __o[sync]="${2:-}" ; shift ;;
    --help       | -h ) __o[help]=1 ;; 
    --version    | -v ) __o[version]=1 ;; 
    -- ) shift ; break ;;
    *  ) break ;;
  esac
  shift
done

if [[ ${__o[help]:-} = 1 ]]; then
  ___printhelp
  exit
elif [[ ${__o[version]:-} = 1 ]]; then
  ___printversion
  exit
fi

[[ ${__lastarg:="${!#:-}"} =~ ^--$|${0}$ ]] \
  && __lastarg="" \
  || true


main "${@:-}"


