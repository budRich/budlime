#!/usr/bin/env bash

__name="sublaction"
__version="0.01"
__author="budRich"
__contact='robstenklippa@gmail.com'
__created="2018-08-15"
__updated="2018-08-23"

main(){

  eval set -- "$(getopt --name "$__name" \
    --options vh:: \
    --longoptions version,help::,debug: \
    -- "$@"
  )"

  while true; do
    case "$1" in
      -v | --version ) printinfo version ; exit ;;
      -h | --help ) printinfo "${2:-}" ; exit ;;
      -- ) shift; break ;;
      * ) break ;;
    esac
  done

  declare -a __gfiles # files to git

  __pkgSourceDir="$HOME/tmp/stpkg"
  __sublimeDir="$HOME/.config/sublime-text-3/Packages"
  __budlimeDir="$HOME/git/lab/budlime/packages"
  __gitDir="$HOME/git"

  __atit=($(tits -i sublime_main -napf))

  __sblwid=${__atit[0]}

  [[ -z $__sblwid ]] && ERX "no sublime_main window found"

  __sblact=${__atit[1]}
  __sblprj=${__atit[2]}
  __sblfil="${__atit[@]:3}"

  [[ -f $__sblfil ]] || ERX "$__sblfil : file not found"

  __sbldir="${__sblfil%/*}"
  __sblnmn="${__sblfil##*/}"

  __sblbase="$(readlink -f "$__sblfil")"
  __sblbasedir="${__sblbase%/*}"
  __sblbasename="${__sblbase##*/}"

  

  if [[ $__sbldir =~ ^${__sublimeDir} ]];then
    # file is in sublime packages directory:
    copy_sublime_setting_to_budlime
  elif command -v "${__sblfil}" > /dev/null 2>&1; then
    update_script
  elif [[ $__sbldir =~ ^${__pkgSourceDir} ]];then

    trgfil="$__sublimeDir${__sblfil#$__pkgSourceDir}"
    trgdir="${trgfil%/*}"
    mkdir -p "$trgdir"

    cp "${__sblfil}" "${trgfil}"

  elif [[ $__sbldir =~ ^${__gitDir} ]];then
    __gfiles=("${__sblbase}")
    commit_to_git
  else # assume dotfile, move to ~/git...
    dot_to_git
  fi

}

dot_to_git(){
  
  local trgdir

  trgdir="$(oneliner -p "'move file to dir: '" -f '~/git')"
  [[ -z $trgdir ]] && ERX "no target directory chosen"

  sublaunch -i sublime_main
  subl --command "close"
  
  trgdir="${trgdir/'~'/$HOME}"

  mkdir -p "${trgdir}"
  mv "${__sblbase}" "${trgdir}"

  ln -s "$trgdir/${__sblbasename}" \
        "${__sblbase}"

  # re-open file, now in ~/git...
  subl "${__sblbase}"
}

update_script(){
  local  firstline readme msg manpage trgdir category

  firstline="$(head -1 "$__sblfil")"
  
  [[ $firstline =~ ^(#!).*bash ]] || ERX "not a bash script"

  # script is located in ~/git
  if [[ $__sblbase =~ ^${__gitDir} ]]; then
    # bump version, update date
    awk -i inplace -v today="$(date +'%Y-%m-%d')" -F'=' '{
      if ($1 == "__version") {
        gsub(/["]/,"",$2)
        print $1 "=\"" $2 + 0.001 "\""
      } else if ($1 == "__updated") {
        print $1 "=\"" today "\""
      } else {print $0}
    }' "${__sblbase}"

    # update documentation
    readme="${__sblbasedir}/README.md"
    manpage="${__sblbasedir}/${__sblbasename%.*}.1"

    "${__sblbase}" -hmdg
    "${__sblbase}" -hman

    __gfiles=("${__sblbase}")
    [[ -f $manpage ]] && __gfiles+=("${manpage}")
    [[ -f $readme ]]  && __gfiles+=("${readme}")

    # add changes to git, commit if message is given
    commit_to_git

  else # script is not located in ~/git...
    
    trgdir="$(oneliner -p 'move script to dir: ' -f '~/git')"
    [[ -z $trgdir ]] && ERX "no target directory chosen"
    
    category="$(oneliner -p 'category: ' -l "$(ls ~/src/bash | grep -v new)")"
    [[ -z $category ]] && ERX "no category chosen"

    trgdir="${trgdir/'~'/$HOME}"
    mkdir -p "$trgdir"

    # close the file in sublime before moving it
    sublaunch -i sublime_main
    subl --command "close"
    
    mv "${__sblbase}" "$trgdir/${__sblbasename%.*}.sh"

    [[ -n $category ]] && {
      mkdir -p "$HOME/src/bash/$category"
      ln -s "$trgdir/${__sblbasename%.*}.sh" \
            "$HOME/src/bash/$category/${__sblbasename%.*}"
    }

    # re-open file, now in ~/git...
    subl "$trgdir/${__sblbasename%.*}.sh"
  fi
  # if script is not in git dir, move it there
  # update documentation?
}

commit_to_git(){
(
  cd "${__sblbasedir}" || ERX "cd $__sblbasedir failed"
  git add "${__gfiles[@]}" && {
    msg="$(oneliner -p 'commit message: ')"
    [[ -n $msg ]] && {
      msg="${__sblbasename}: $msg"
      dunstify "$(git commit -m "$msg" "${__gfiles[@]}")"
    }
  }
)
}

copy_sublime_setting_to_budlime(){
  mkdir -p "${__sbldir/$__sublimeDir/$__budlimeDir}"
  [[ -f "${__sblfil/$__sublimeDir/$__budlimeDir}" ]] \
    || cp "${__sblfil}" "${__sblfil/$__sublimeDir/$__budlimeDir}"
}

printinfo(){
about='`sublaction` - Do stuff with the currently open file in sublime

SYNOPSIS
--------

`sublaction` [[`-v|--version`]|[`-h|--help`]]  

DESCRIPTION
-----------

`sublaction` uses `tits` to get information about the
currently open file in sublime. If `sublaction` is
executed without any arguments, it will try to figure
out the action by it self by analyzing the path of the
file.  


OPTIONS
-------

`-v`  
Show version and exit.  

`-h`  
Show help and exit.  

DEPENDENCIES
------------

go-md2man  
tits  
Sublime Text  
oneliner  
rofi  
'

bouthead="
${__name^^} 1 ${__updated} Linux \"User Manuals\"
=======================================

NAME
----
"

boutfoot="
AUTHOR
------

${__author} <${__contact}>
<https://budrich.github.io>

SEE ALSO
--------

tits(1), rofi(1), oneliner(1)
"


  case "$1" in
    # print version info to stdout
    version )
      printf '%s\n' \
        "$__name - version: $__version" \
        "updated: $__updated by $__author"
      exit
      ;;
    # print help in markdown format to stdout
    md ) printf '%s' "# ${about}" ;;

    # print help in markdown format to README.md
    mdg ) printf '%s' "# ${about}" > "${__dir}/README.md" ;;
    
    # print help in troff format to __dir/__name.1
    man ) 
      printf '%s' "${bouthead}" "${about}" "${boutfoot}" \
      | go-md2man > "${__dir}/${__name}.1"
    ;;

    # print help to stdout
    * ) 
      printf '%s' "${about}" | awk '
         BEGIN{ind=0}
         $0~/^```/{
           if(ind!="1"){ind="1"}
           else{ind="0"}
           print ""
         }
         $0!~/^```/{
           gsub("[`*]","",$0)
           if(ind=="1"){$0="   " $0}
           print $0
         }
       '
    ;;
  esac
}

ERR(){ >&2 echo "[WARNING]" "$*"; }
ERX(){ >&2 echo "[ERROR]" "$*" && exit 1 ; }

init(){
  set -o errexit
  set -o pipefail
  set -o nounset
  # set -o xtrace

  __source="$(readlink -f "${BASH_SOURCE[0]}")"
  __dir="$(cd "$(dirname "${__source}")" && pwd)"
  __file="${__dir}/$(basename "${__source}")"
  __base="$(basename ${__file} .sh)"
  __root="$(cd "$(dirname "${__dir}")" && pwd)" # <-- change this as it depends on your app
}

init
eval __lastarg="\${$#}"
main "${@}"
