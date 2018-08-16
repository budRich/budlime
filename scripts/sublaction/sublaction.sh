#!/usr/bin/env bash

__name="sublaction"
__version="0.001"
__author="budRich"
__contact='robstenklippa@gmail.com'
__created="2018-08-15"
__updated="2018-08-15"

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

  __sublimeDir="$HOME/.config/sublime-text-3/Packages"
  __budlimeDir="$HOME/git/lab/budlime/packages"
  __gitDir="$HOME/git"

  __atit=($(tits -i sublime_main -napf))

  __sblwid=${__atit[0]}
  __sblact=${__atit[1]}
  __sblprj=${__atit[2]}
  __sblfil="${__atit[@]:3}"
  __sbldir="${__sblfil%/*}"
  __sblnmn="${__sblfil##*/}"

  [[ -z $__sblwid ]] && ERX "no sublime_main window found"

  if [[ $__sbldir =~ ^${__sublimeDir} ]];then
    # file is in sublime packages directory:
    copy_sublime_setting_to_budlime
  elif command -v "${__sblfil}" > /dev/null 2>&1; then
    update_script
  else
    dunstify "$__sblfil"
  fi

}

update_script(){
  local base firstline basedir basename readme 
  local msg manpage

  firstline="$(head -1 "$__sblfil")"
  base="$(readlink -f "$__sblfil")"
  basedir="${base%/*}"
  basename="${base##*/}"
  [[ $firstline =~ ^(#!).*bash ]] || ERX "not a bash script"

  dunstify "$base"
  if [[ $base =~ ^${__gitDir} ]]; then
    readme="${basedir}/README.md"
    manpage="${basedir}/${basename%.*}.1"
    "${base}" -hmdg
    "${base}" -hman
    gfiles=("${base}" "${readme}" "${manpage}")
    git add "${gfiles[@]}"
    msg="$(oneliner -p 'commit message: ')"
    [[ -n $msg ]] && {
      dunstify "$(git commit -m "$msg" "${gfiles[@]}")"
    }
  else
    dunstify "its not in git"
  fi
  # if script is not in git dir, move it there
  # update documentation?
}

commit_to_git(){
  dunstify "comi"
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
`sublaction` `--menu`|`-m`  

DESCRIPTION
-----------

`sublaction` uses `tits` to get information about the
currently open file in sublime. If `sublaction` is
executed without any arguments, it will try to figure
out the action by it self by analyzing the path of the
file. If it can'"'"' figure out tha action or if the
`-m|--menu` option is used. A rofi menu with options
will be displayed.. 

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
${__name^^} 1 ${__created} Linux \"User Manuals\"
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
