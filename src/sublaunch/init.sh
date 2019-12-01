#!/usr/bin/env bash

___printversion(){
  
cat << 'EOB' >&2
sublaunch - version: 2019.12.01.0
updated: 2019-12-01 by budRich
EOB
}


# environment variables
: "${SUBLIME_TITS_CRIT:=class}"
: "${SUBLIME_TITS_SRCH:=Sublime_text}"
: "${SUBLIME_PROJECTS_DIR:=$XDG_CONFIG_HOME/sublime-text-3/Packages/User/Projects}"


___printhelp(){
  
cat << 'EOB' >&2
sublaunch - Run or raise sublime with a specific profile and file


SYNOPSIS
--------
sublaunch [--instance|-i INSTANCE] [--options|-o  OPTIONS] [--project|-j  PROJECT] [FILE]
sublaunch [--class|-c    CLASS] [--options|-o  OPTIONS] [--project|-j  PROJECT] [FILE]
sublaunch [--profile|-p  PROFILE] [--options|-o  OPTIONS] [--project|-j  PROJECT] [FILE]
sublaunch --help|-h
sublaunch --version|-v

OPTIONS
-------

--instance|-i INSTANCE  
Set the criterion to be a window with the
instance name INSTANCE. Defaults to the value of
SUBLIME_TITS_SRCH.


--options|-o OPTIONS  
Additional commandline otions that will get
passed to sublime sublime (subl) when a new window
is created.




--project|-j PROJECT  
If a project in $PROJECT_DIR with the name
PROJECT.sublime-project exist. That project will
get opened if the window doesn't exist. If both
this and --profile is set, --profile will have
priority.


--class|-c CLASS  
Set the criterion to be a window with the class
name CLASS. Defaults to the value of
SUBLIME_TITS_SRCH.


--profile|-p PROFILE  
Set the criterion to be a window with the
instance name: sublime_PROFILE. And if a project
in $PROJECT_DIR with the name
PROFILE.sublime-project exist. That project will
get opened if the window doesn't exist.


--help|-h  
Show help and exit.


--version|-v  
Show version and exit
EOB
}


for ___f in "${___dir}/lib"/*; do
  source "$___f"
done

declare -A __o
eval set -- "$(getopt --name "sublaunch" \
  --options "i:o:j:c:p:hv" \
  --longoptions "instance:,options:,project:,class:,profile:,help,version," \
  -- "$@"
)"

while true; do
  case "$1" in
    --instance   | -i ) __o[instance]="${2:-}" ; shift ;;
    --options    | -o ) __o[options]="${2:-}" ; shift ;;
    --project    | -j ) __o[project]="${2:-}" ; shift ;;
    --class      | -c ) __o[class]="${2:-}" ; shift ;;
    --profile    | -p ) __o[profile]="${2:-}" ; shift ;;
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
  && __lastarg="" 





