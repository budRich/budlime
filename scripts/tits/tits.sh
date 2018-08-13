#!/bin/bash

NAME="tits"
VERSION="0.001"
AUTHOR="budRich"
CONTACT='robstenklippa@gmail.com'
CREATED="2018-08-06"
UPDATED="2018-08-06"

main(){

  : "${SUBLIME_TITS_CRIT:=c}"
  : "${SUBLIME_TITS_SRCH:=Sublime_text}"

  while getopts :vhsanpfdlc:i: option; do
    case "${option}" in
      s|p|f|d|l|n|a) __ret+=("$option") ;;
      c|i) SUBLIME_TITS_CRIT="${option}" SUBLIME_TITS_SRCH="${OPTARG}" ;;

      v) printf '%s\n' \
           "$NAME - version: $VERSION" \
           "updated: $UPDATED by $AUTHOR"
         exit ;;
      h|*) printinfo && exit ;;

    esac
  done

  declare -A __tits

  eval "$(wmctrl -lx | awk -v c="${SUBLIME_TITS_CRIT}" -v s="${SUBLIME_TITS_SRCH}" -v home="${HOME}" '
    (c == "c" && $3 ~ s"$") || (c == "i" && $3 ~ "^"s) {
      print "__tits[n]=\"$((" $1 "))\""
      print "__tits[a]=" $2
      $1=$2=$3=$4=""
      sub(/^[[:space:]]*/,"",$0)
      sub(" - Sublime Text$","",$0)
      if ($0 ~ /[)]$/) {
        project=$NF
        gsub(/[()]/,"",project)
        sub("[[:space:]][(]" project "[)]","",$0)
        print "__tits[p]=\"" project "\""
      }

      if ($0 ~ /[•]$/) {
        sub(/ [•].*$/,"",$0)
        print "__tits[s]=1"
      } else {print "__tits[s]=0"}

      file=$0
      print "__tits[l]=\"" file "\""
      sub(/~/,home,file)
      print "__tits[f]=\"" file "\""
      sub("/?[^/]*/?$","",file)
      print "__tits[d]=\"" file "\""
      
      
    }
  ')"

  ((${#__ret[@]}==0)) && __ret[0]=f

  for r in "${__ret[@]}"; do
    [[ -n ${__tits[$r]} ]] && echo "${__tits[$r]}"
  done


}

printinfo(){
about='`tits` - Prints the title of the currently open sublime window.

SYNOPSIS
--------

`tits` [`-v`|`-h`]  
`tits` [ [`-c` CLASS]|[`-i` INSTANCE] ][`-fpsdna`]  

DESCRIPTION
-----------

`tits` uses `wmctrl` to get the title of the window with the
class name **Sublime_text**. The title looks different depending
on the status of the file, if Sublime is registered and if a project
is open. Below are the different title variations:  

``` text
# FILE (PROJECT) - Sublime Text
~/git/lab/budlime/scripts/tits/tits.sh (budlime) - Sublime Text

# FILE DIRTY (PROJECT) - Sublime Text
~/git/lab/budlime/scripts/tits/tits.sh • (budlime) - Sublime Text

# FILE - Sublime Text
~/git/lab/budlime/scripts/tits/tits.sh - Sublime Text

# FILE DIRTY - Sublime Text
~/git/lab/budlime/scripts/tits/tits.sh • - Sublime Text
```

If `tits` is executed without any arguments, the filename is printed.  


OPTIONS
-------

`-v`  
Show version and exit.

`-h`  
Show help and exit.

`-f`  
Prints the full path of the currently open file.

`-l`  
Same as `-f` but with `~` instead of `$HOME`.

`-d`  
Prints the directory of the currently open file.

`-s`  
Prints the status (dirty=1|clean=0).  
Dirty means that the file is not saved.  

`-a`  
Prints the `1` if the window is focused.  
Otherwise `0` is printed.    

`-n`  
Prints the window ID of the found window.   

`-p`  
Prints the project name.

`-c` *CLASS*  
Sets `SUBLIME_TITS_CRIT` to c and  
`SUBLIME_TITS_SRCH` to *CLASS*  

`-i` *INSTANCE*  
Sets `SUBLIME_TITS_CRIT` to i and  
`SUBLIME_TITS_SRCH` to *INSTANCE*  

EXAMPLES
--------

Goto the same directory as the currently open file:  
`$ cd "$(tits -d)"`  

`$ alias cds='"'"'cd "$(tits -d)"'"'"'`  

ENVIRONMENT
-----------
SUBLIME_TITS_CRIT  
Default criteria to use if `-c` or `-i` is not set.
Defaults to "c"  

SUBLIME_TITS_SRCH
Default search string to use if `-c` or `-i` is not set.
Defaults to "Sublime_text"  

DEPENDENCIES
------------

Sublime Text  
wmctrl  
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

wmctrl(1)
"


  case "$1" in
    m ) printf '%s' "# ${about}" ;;
    
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
