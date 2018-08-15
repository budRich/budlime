#!/usr/bin/env bash

__name="browserpreview"
__version="0.001"
__author="budRich"
__contact='robstenklippa@gmail.com'
__created="2018-08-15"
__updated="2018-08-15"

main(){

  local class command option

  eval set -- "$(getopt --name "$__name" \
    --options vh:: \
    --longoptions version,help:: \
    -- "$@"
  )"


  while true; do
    [[ $1 = -- ]] && option=$1 || {
      option="${1##--}" 
      option="${option##-}"   
    }

    case "$option" in
      v | version ) printinfo version ; exit ;;
      h | help ) printinfo "${2:-}" shift 2 ; exit ;;
      -- ) shift; break ;;
      * ) break ;;
    esac
  done

  class="Vivaldi-stable"
  command="vivaldi-stable --extensions-on-chrome-urls --debug-packed-apps --silent-debugger-extension-api"

  # command="palemoon"
  # instance="Navigator"

  { pgrep -f cvim_server.py || cvim_server.py & } > /dev/null 2>&1
  i3run -g -c Vivaldi-main -x "$class" -e "${command}"
  [[ -n $1 ]] && {
    url="${1}"
    [[ -f $url ]] && url='file://'"${url}"
    echo -n "${url}" | xclip -selection clipboard
    sleep .1
    xdotool search --onlyvisible --class Vivaldi-main key Escape P
    i3fyra -m D
    i3fyra -z B
    i3fyra -l AB=900
    sublaunch -p main
  }

}

printinfo(){
about='`browserpreview` - opens target url or file in vivaldi

SYNOPSIS
--------

`browserpreview` [`-v`|`-h`]   
`browserpreview` URL   
`browserpreview` FILE   

DESCRIPTION
-----------

`browserpreview` opens URL or FILE in vivaldi, and
places the vivaldi window in container D, hides, container 
B set the AB split to 900 and focuses the main sublime window.

I created this to go with the sublime text package
`MarkdownPreview`.

OPTIONS
-------

`-v|--version`  
Show version and exit.

`-h|--help`  
Show help and exit.


DEPENDENCIES
------------

go-md2man  
Sublime Text  
Vivaldi  
i3fyra  
i3run   
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

wmctrl(1)
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
  # set -o errexit
  set -o pipefail
  set -o nounset
  # set -o xtrace

  __source="$(readlink -f "${BASH_SOURCE[0]}")"
  __dir="$(cd "$(dirname "${__source}")" && pwd)"
  # __file="${__dir}/$(basename "${__source}")"
  # __base="$(basename ${__file} .sh)"
  # __root="$(cd "$(dirname "${__dir}")" && pwd)" # <-- change this as it depends on your app
}

init
eval __lastarg="\${$#}"
main "${@}"
