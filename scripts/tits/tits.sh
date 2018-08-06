#!/bin/bash

NAME="tits"
VERSION="0.001"
AUTHOR="budRich"
CONTACT='robstenklippa@gmail.com'
CREATED="2018-08-06"
UPDATED="2018-08-06"

main(){

  declare -A tits

  eval "$(wmctrl -lx | awk -v home="${HOME}" '
    $3 ~ /Sublime_text$/ {
      $1=$2=$3=$4=""
      sub(/^[[:space:]]*/,"",$0)
      sub(" - Sublime Text$","",$0)
      if ($0 ~ /[•]$/) {
          sub(/ [•].*$/,"",$0)
          print "tits[s]=\"dirty\""
        }
      else if ($0 ~ /[^)]$/) {print "tits[s]=\"clean\""}
      else {
        project=$NF
        gsub(/[()]/,"",project)
        print "tits[p]=\"" project "\""
        sub(/ [(].*$/,"",$0)
        if ($0 ~ /[•]$/) {
          sub(/ [•].*$/,"",$0)
          print "tits[s]=\"dirty\""
        }
        else if ($0 ~ /[^)]$/) {print "tits[s]=\"clean\""}
      }
      file=$0
      sub(/~/,home,file)
      print "tits[f]=\"" file "\""
      sub("/?[^/]*/?$","",file)
      print "tits[d]=\"" file "\""
    }
  ')"

  while getopts :vhspfd option; do
    case "${option}" in
      s|p|f|d) [[ -n ${tits[$option]} ]] && echo ${tits[$option]} ;;

      v) printf '%s\n' \
           "$NAME - version: $VERSION" \
           "updated: $UPDATED by $AUTHOR"
         exit ;;
      h|*) printinfo && exit ;;

    esac
  done

  ((${#}==0)) && [[ -n ${tits[f]} ]] && echo ${tits[f]}

}

printinfo(){
about='`tits` - Prints the title of the currently open sublime window.

SYNOPSIS
--------

`tits` [`-v`|`-h`]
`tits` [`-f`][`-p`][`-s`]

DESCRIPTION
-----------

`tits` uses `xdotool` to get the title of the window with the
class name **Sublime_text**. The title looks different depending
on the status of the file, if Sublime is registered and if a project
is open. Below are the different title variations:  

``` text
# FILR (PROJECT) - Sublime Text
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
Prints the filename of the currently open file.

`-d`
Prints the directory of the currently open file.

`-s`  
Prints the status (dirty|clean). dirty means that the file is not saved.

`-p`  
Prints the project name.


DEPENDENCIES
------------

Sublime Text
xdotool
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

xdotool(1)
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
