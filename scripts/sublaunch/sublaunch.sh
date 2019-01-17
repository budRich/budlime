#!/usr/bin/env bash

__name="sublaunch"
__version="0.001"
__author="budRich"
__contact='robstenklippa@gmail.com'
__created="2018-08-06"
__updated="2018-08-06"

main(){

  eval set -- "$(getopt --name "$__name" \
    --options vh::c:i:p:j:o: \
    --longoptions version,help::,class:,instance:,profile:,project:,options: \
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
      i | instance ) 
        SUBLIME_TITS_CRIT=${option:0:1}
        SUBLIME_TITS_SRCH="$2"
        shift 2
        ;;
      p | profile ) 
        SUBLIME_TITS_CRIT=i
        SUBLIME_TITS_SRCH="sublime_$2"
        trg_proj="$2"
        shift 2 
        ;;
      j | project ) trg_proj="$2" ; shift 2 ;;
      o | options ) opts="${2}"   ; shift 2 ;;
      -- ) shift; break ;;
      * ) break ;;
    esac
  done

  __tits+=($(tits -napf))


  if [[ -z "${__tits[1]:-}" ]]; then
    cmd=(subl)
    [[ -n $(pidof sublime_text) ]] && cmd+=('--new-window')
    
    [[ -n ${opts:-} ]] && cmd+=(${opts})

    : "${SUBLIME_PROJECTS_DIR:=$HOME/.config/sublime-text-3/Packages/User/Projects/}"
    project_ext="sublime-project"

    [[ -n ${trg_proj:-} ]] && {
      proj_file="${SUBLIME_PROJECTS_DIR}/${trg_proj}.${project_ext}"
      [[ -f "$proj_file" ]] \
        && cmd+=("--project" "$proj_file")
    }
    
    eval "${cmd[@]}"

    while [[ -z "${__tits[1]:-}" ]]; do
        __tits=($(tits -napf -i sublime_text))
      sleep .15
    done


    cmd=('xdotool' set_window)
    cmd+=('--classname' "$SUBLIME_TITS_SRCH")
    cmd+=(${__tits[0]})

    eval "${cmd[@]}"

  fi

  echo "${__tits[0]}"

  xdotool windowfocus "${__tits[0]}"
  [[ -f ${__lastarg:-} ]] && {
    sleep .3
    xdotool windowfocus "${__tits[0]}"
    subl "$__lastarg"
    sleep .1
  } &


}

printinfo(){
about='`sublaunch` - Run or raise sublime with a specific profile and file

SYNOPSIS
--------

`sublaunch` [`-v`|`-h`]   

DESCRIPTION
-----------

`sublaunch` takes a number of criterion to identify
a sublime window. If `sublaunch` can'"'"' find a open window
matching the criteria. A new sublime window will be opened
and it'"'"'s **instance name** will be renamed to match the criteria.

OPTIONS
-------

`-v|--version`
Show version and exit.

`-h|--help`
Show help and exit.

`-i|--instance` INSTANCE  
Set the criterion to be a window with the instance name 
INSTANCE. Defaults to the value of SUBLIME_TITS_SRCH.  

`-p|--profile` PROFILE   
Set the criterion to be a window with the instance name: 
`sublime_PROFILE`. And if a project in $PROJECT_DIR with
the name PROFILE.sublime-project exist. That project will
get opened if the window doesn'"'"'t exist.  

`-j|--project` PROJECT
If a project in $PROJECT_DIR with
the name PROJECT.sublime-project exist. That project will
get opened if the window doesn'"'"'t exist. If both this
and `--profile` is set, `--profile` will have priority.  

`-o|--otions` OTIONS  
Additional commandline otions that will get passed to sublime
sublime \(`subl`\) when a new window is created.

ENVIRONMENT
-----------

`FOOCONF`
If non-null the full pathname for an alternate system wide */etc/foo.conf*.
Overridden by the `-c` option.

DEPENDENCIES
------------

go-md2man
i3get
Sublime Text  
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
