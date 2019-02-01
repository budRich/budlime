#!/usr/bin/env bash

___printversion(){
  
cat << 'EOB' >&2
install - version: 2019.02.01.5
updated: 2019-02-01 by budRich
EOB
}


# environment variables
: "${SUBLIME_DIR:=$XDG_CONFIG_HOME/sublime-text-3}"


___printhelp(){
  
cat << 'EOB' >&2
install - Installs the budlime setup 


OPTIONS
-------
EOB
}


for ___f in "${___dir}/lib"/*; do
  source "$___f"
done





