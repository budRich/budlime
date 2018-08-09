#!/bin/bash

NAME="subdox"
VERSION="0.001"
AUTHOR="budRich"
CONTACT='robstenklippa@gmail.com'
CREATED="2018-08-05"
UPDATED="2018-08-05"

THIS_DIR="$( cd "$( dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd )"

main(){
  while getopts :vh option; do
    case "${option}" in
      v) printf '%s\n' \
           "$NAME - version: $VERSION" \
           "updated: $UPDATED by $AUTHOR"
         exit ;;

      h|*) printinfo && exit ;;
    esac
  done

  GTFM_CONFIG="${THIS_DIR}/subdox.ini" GTFM
}

printinfo(){
about='`subdox` - Downloads sublime related documentation.

SYNOPSIS
--------

`subextract` [`-v`|`-h`]  

DESCRIPTION
-----------

`subdox` uses `GTFM` to download sublime related
documentation. See `subdox.ini` for more info.


OPTIONS
-------

`-v`  
Show version and exit.

`-h`  
Show help and exit.

DEPENDENCIES
------------

GTFM  
'

bouthead="
${NAME^^} 1 ${CREATED} Linux \"User Manuals\"
=======================================

NAME
----
"

boutfoot="
AUTHOR
------

${AUTHOR} <${CONTACT}>
<https://budrich.github.io>

SEE ALSO
--------

GTFM(1)
"


  case "$1" in
    m ) printf '%s' "${about}" ;;
    
    f ) 
      printf '%s' "${bouthead}"
      printf '%s' "${about}"
      printf '%s' "${boutfoot}"
    ;;

    ''|* ) 
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

ERR(){ >&2 echo "[WARNING]" $@; }
ERX(){ >&2 echo "[ERROR]" $@ && exit 1 ; }

if [ "$1" = "md" ]; then
  printinfo m
  exit
elif [ "$1" = "man" ]; then
  printinfo f
  exit
else
  main "${@}"
fi
