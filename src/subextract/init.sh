#!/usr/bin/env bash

___printversion(){
  
cat << 'EOB' >&2
subextract - version: 2019.02.01.2
updated: 2019-02-01 by budRich
EOB
}


# environment variables
: "${SUBLIME_DIR:=$XDG_CONFIG_HOME/sublime-text-3}"


___printhelp(){
  
cat << 'EOB' >&2
subextract - Sync and extract packages for Sublime Text


SYNOPSIS
--------
subextract [--clean|-c] [--blank|-d] [--quite|-q] [--extract|-e] [--force|-f] [--sync|-s PACKAGE_DIRECTORY]
subextract --help|-h
subextract --version|-v

OPTIONS
-------

--clean|-c  
Move the current $PKG_DIR to $SUB_DIR/backup
before any other operations.  


--blank|-d  
Blank extracted default files. (only in effect
when --extract is used)


--quite|-q  
Execute without output and messages.



--extract|-e  
Extract packages default settingfiles to $PKG_DIR


--force|-f  
Force files from PACKAGE_DIRECTORY to overwrite,
no matter if target file exists (-p) or is newer
(-s).

--sync|-s PACKAGE_DIRECTORY  
Sync files in PACKAGE_DIRECTORY with files in
$PKG_DIR. Works both ways, the newest file will
overwrite the oldest.


--help|-h  
Show help and exit.


--version|-v  
Show version and exit.

EOB
}


for ___f in "${___dir}/lib"/*; do
  source "$___f"
done

declare -A __o
eval set -- "$(getopt --name "subextract" \
  --options "cdqefs:hv" \
  --longoptions "clean,blank,quite,extract,force,sync:,help,version," \
  -- "$@"
)"

while true; do
  case "$1" in
    --clean      | -c ) __o[clean]=1 ;; 
    --blank      | -d ) __o[blank]=1 ;; 
    --quite      | -q ) __o[quite]=1 ;; 
    --extract    | -e ) __o[extract]=1 ;; 
    --force      | -f ) __o[force]=1 ;; 
    --sync       | -s ) __o[sync]="${2:-}" ; shift ;;
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





