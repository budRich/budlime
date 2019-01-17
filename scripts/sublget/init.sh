#!/usr/bin/env bash

___printversion(){
  
cat << 'EOB' >&2
sublget - version: 2019.01.17.18
updated: 2019-01-17 by budRich
EOB
}


# environment variables
: "${SUBLIME_TITS_CRIT:=class}"
: "${SUBLIME_TITS_SRCH:=Sublime_text}"


___printhelp(){
  
cat << 'EOB' >&2
sublget - Prints the title of the currently open sublime window


SYNOPSIS
--------
sublget [--follow|-o] [--long|-l] [--print|-r OUTPUT]
sublget --class|-c CLASS  [--follow|-o] [--long|-l] [--print|-r OUTPUT]
sublget --instance|-i INSTANCE [--follow|-o] [--long|-l] [--print|-r OUTPUT] 
sublget --help|-h
sublget --version|-v

OPTIONS
-------

--follow|-o  
Will print the source of file/directory if it is
symlinked.


--long|-l  
Will replace ~ with expanded $HOME of file.


--print|-r OUTPUT  
OUTPUT can be one or more of the following 
characters:  

|character | print
|:---------|:-----
|f       | File  
|d       | Directory  
|p       | Project  
|s       | Status  
|n       | Window ID  
|w       | workspace  




--class|-c CLASS  
Sets SUBLIME_TITS_CRIT to c and SUBLIME_TITS_SRCH
to CLASS


--instance|-i INSTANCE  
Sets SUBLIME_TITS_CRIT to i and SUBLIME_TITS_SRCH
to INSTANCE


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
eval set -- "$(getopt --name "sublget" \
  --options "olr:c:i:hv" \
  --longoptions "follow,long,print:,class:,instance:,help,version," \
  -- "$@"
)"

while true; do
  case "$1" in
    --follow     | -o ) __o[follow]=1 ;; 
    --long       | -l ) __o[long]=1 ;; 
    --print      | -r ) __o[print]="${2:-}" ; shift ;;
    --class      | -c ) __o[class]="${2:-}" ; shift ;;
    --instance   | -i ) __o[instance]="${2:-}" ; shift ;;
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





