#!/usr/bin/env bash

___printversion(){
  
cat << 'EOB' >&2
sublsynkl - version: 2019.01.18.10
updated: 2019-01-18 by budRich
EOB
}


# environment variables
: "${SUBLIME_DIR:=$XDG_CONFIG_HOME/sublime-text-3}"
: "${SUBLIME_SRC:=/opt/sublime_text}"


___printhelp(){
  
cat << 'EOB' >&2
sublsynkl - Creates a settings project as an alternative to the default sublime settings system.


SYNOPSIS
--------
sublsynkl --packages|-p PACKAGE_DIRECTORY [--clean|-c] [--blank|-d] [--extract|-e] [--force|-f] 
sublsynkl --sync|-s PACKAGE_DIRECTORY  [--force|-f]
sublsynkl --help|-h
sublsynkl --version|-v

OPTIONS
-------

--packages|-p PACKAGE_DIRECTORY  
Copy files withing PACKAGE_DIRECTORY before any
other operations.  



--clean|-c  
Clean install. Move the current
$SUBLIME_DIR/Packages to $SUBLIME_DIR/backup
before any other operations.  


--blank|-d  
Blank extracted default files. (only have effect
if --extract is used)


--extract|-e  
Extract packages default setting files to
$SUBLIME_DIR/Packages.


--force|-f  
Force files from PACKAGE_DIRECTORY to overwrite,
no matter if target file exists (when used with
--packages)  or is newer (when used with --sync).


--sync|-s PACKAGE_DIRECTORY  
Sync files in PACKAGE_DIRECTORY with files in
$SUBLIME_DIR/Packages. Works both ways, the newest
file will overwrite the oldest.


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
eval set -- "$(getopt --name "sublsynkl" \
  --options "p:cdefs:hv" \
  --longoptions "packages:,clean,blank,extract,force,sync:,help,version," \
  -- "$@"
)"

while true; do
  case "$1" in
    --packages   | -p ) __o[packages]="${2:-}" ; shift ;;
    --clean      | -c ) __o[clean]=1 ;; 
    --blank      | -d ) __o[blank]=1 ;; 
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
  && __lastarg="" \
  || true





