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

  declare -A _tits

  # example wmctrl -lx output
  # 0x00c00065  0 tiledterm.URxvt  biglab tiledterm
  eval "$(wmctrl -lx | awk \
    -v c="${SUBLIME_TITS_CRIT:0:1}" \
    -v s="${SUBLIME_TITS_SRCH}" \
    -v r="$_ret" '
    match($0,/([0-9a-fx]{10})\s+([0-9-]{1,2})\s+([^.]+)[.](\S+)\s+(\S+)\s+(.+)$/,ma) {
      # 0x00c00065  0 tiledterm.URxvt       biglab tiledterm
      wid=ma[1] # id
      wwd=ma[2] # workspace
      win=ma[3] # instance
      wcl=ma[4] # class
      who=ma[5] # host
      wti=ma[6] # title

      if ((c == "c" && wcl == s) || (c == "i" && win == s)) {
        # example sublime title
        # FILE • (PROJECT) - Sublime Text
        # FILE (PROJECT) - Sublime Text
        # FILE • - Sublime Text
        # FILE - Sublime Text

        match(wti,/^(.+\w)(\s[•])?(\s+[(](.+)[)])? - Sublime Text.*$/,sma)
        sfil=sma[1] # file
        ssts=sma[2] # status
        sprj=sma[4] # project

        if (ssts ~ /./) {ssts=1}
        else {ssts=0}

        print "_tits[f]=\"" gensub("~",ENVIRON["HOME"],"1",sfil) "\""
        print "_tits[s]=\"" ssts "\""
        print "_tits[p]=\"" sprj "\""
        print "_tits[w]=\"" wwd "\""
        print "_tits[n]=\"" strtonum(wid) "\""

        exit
      }

    }'
  )"

  : "${__o[print]:=f}"

  ((__o[follow]==1)) && _tits[f]="$(readlink -f "${_tits[f]}")"
  ((__o[long]==1))   || _tits[f]="${_tits[f]/$HOME/'~'}"

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
