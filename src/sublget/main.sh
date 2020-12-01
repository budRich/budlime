#!/usr/bin/env bash

main(){

  for o in "${!__o[@]}"; do
    case "$o" in
      class|instance) 
        SUBLIME_TITS_CRIT="$o"
        SUBLIME_TITS_SRCH="${__o[$o]}" 
      ;;
    esac
  done

  # example sublime title
  # 0x03600007  0 sublime_main.Sublime_text  dellen ~/git/bud/budlime/src/sublget/main.sh (sublime) - Sublime Text
  # FILE • (PROJECT) - Sublime Text
  # FILE (PROJECT) - Sublime Text
  # FILE • - Sublime Text
  # FILE - Sublime Text

  l=$(wmctrl -lx )
  re+="([0-9a-fx]{10})\s+([0-9-]+)\s+"

  [[ ${SUBLIME_TITS_CRIT:0:1} = i ]] \
    && re+="($SUBLIME_TITS_SRCH)" || re+="([^.]+)"

  re+='[.]'

  [[ ${SUBLIME_TITS_CRIT:0:1} = c ]] \
    && re+="($SUBLIME_TITS_SRCH)" || re+="(\S+)"

  re+='\s+\S+\s'
  re+='(.+\w)'
  re+='(\s[•])?'
  re+='(\s+[(](.+)[)])?'
  re+=' - Sublime Text'

  declare -A _tits

  [[ $l =~ $re ]] && _tits=(
    [f]=${BASH_REMATCH[5]}    # filename
    [s]=${BASH_REMATCH[6]:+1} # saved
    [p]=${BASH_REMATCH[8]}    # project
    [w]=${BASH_REMATCH[2]}    # workspace
    [n]=${BASH_REMATCH[1]}    # windowid
  )

  : "${__o[print]:=f}"

  _tits[f]="${_tits[f]/'~'/~}"
  ((__o[follow])) && _tits[f]="$(readlink -f "${_tits[f]}")"
  ((__o[long]))   || _tits[f]="${_tits[f]/~/'~'}"

  _tits[d]="${_tits[f]%/*}"

  for ((i=0;i<${#__o[print]};i++)); do
    r="${__o[print]:$i:1}"
    [[ -n ${_tits[$r]} ]] && echo "${_tits[$r]}"
  done

}

___source="$(readlink -f "${BASH_SOURCE[0]}")"  #bashbud
___dir="${___source%/*}"                        #bashbud
source "$___dir/init.sh"                        #bashbud
main "${@}"                                     #bashbud
