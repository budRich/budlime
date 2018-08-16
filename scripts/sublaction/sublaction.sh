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

  __subdir="$HOME/.config/sublime-text-3/Packages"
  __buddir="$HOME/git/lab/budlime/packages"

  atit=($(tits -i sublime_main -napf))

  sblwid=${atit[0]}
  sblact=${atit[1]}
  sblprj=${atit[2]}
  sblfil="${atit[@]:3}"
  sbldir="${sblfil%/*}"
  sblnmn="${sblfil##*/}"

  [[ -z $sblwid ]] && ERX "no sublime_main window found"

  [[ $sbldir =~ ^${__subdir} ]] && {
    mkdir -p "${sbldir/$__subdir/$__buddir}"
    [[ -f "${sblfil/$__subdir/$__buddir}" ]] \
      || cp "${sblfil}" "${sblfil/$__subdir/$__buddir}"
  } || dunstify "$sblfil"


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
will be displayed. 

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
