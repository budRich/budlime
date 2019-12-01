#!/usr/bin/env bash

main(){

  # --instance|-i INSTANCE
  if [[ -n ${__o[instance]} ]]; then
    SUBLIME_TITS_CRIT=instance
    SUBLIME_TITS_SRCH="${__o[instance]}"

  # --class|-c    CLASS
  elif [[ -n ${__o[class]} ]]; then
    SUBLIME_TITS_CRIT=class
    SUBLIME_TITS_SRCH="${__o[class]}"

  # --profile|-p  PROFILE
  elif [[ -n ${__o[profile]} ]]; then
    SUBLIME_TITS_CRIT=instance
    SUBLIME_TITS_SRCH="sublime_${__o[profile]}"
    __o[project]="${__o[profile]}"
  fi

  # --project|-j  PROJECT

  # export SUBLIME_TITS_CRIT="${SUBLIME_TITS_CRIT}"
  # export SUBLIME_TITS_SRCH="${SUBLIME_TITS_SRCH}"

  __tits+=($(sublget -r npf))
  # for k in "${!__tits[@]}"; do echo "$k - ${__tits[$k]}" ;done && exit
  _currentproject="${__tits[1]:-}"
  : "${__o[project]:=$_currentproject}"

  if [[ -z "${_currentproject}" ]]; then
    cmd=(subl)
    [[ -n $(pidof sublime_text) ]] && cmd+=('--new-window')
    
    [[ -n ${__o[options]:-} ]] && cmd+=(${__o[options]})

    project_ext="sublime-project"

    [[ -n ${__o[project]:-} ]] && {
      proj_file="${SUBLIME_PROJECTS_DIR}/${__o[project]}.${project_ext}"
      [[ -f "$proj_file" ]] \
        && cmd+=("--project" "$proj_file")
    }
    
    eval "${cmd[@]}"

    while [[ -z "${__tits[1]:-}" ]]; do
        __tits=($(sublget -r npf -i sublime_text))
      sleep .15
    done

    cmd=('xdotool' set_window)
    cmd+=('--classname' "$SUBLIME_TITS_SRCH")
    cmd+=(${__tits[0]})

    eval "${cmd[@]}"
  
  elif [[ $_currentproject != "${__o[project]}" ]]; then
    project_ext="sublime-project"

    proj_file="${SUBLIME_PROJECTS_DIR}/${__o[project]}.${project_ext}"
    [[ -f "$proj_file" ]] && {
      xdotool windowfocus "${__tits[0]}"
      subl --command 'close_workspace'
      subl --project "$proj_file"
    }

  fi

  {
    xdotool windowfocus "${__tits[0]}" 
    [[ -f ${__lastarg:-} ]] && subl "$__lastarg" 
  } 
  

}

___source="$(readlink -f "${BASH_SOURCE[0]}")"  #bashbud
___dir="${___source%/*}"                        #bashbud
source "$___dir/init.sh"                        #bashbud
main "${@}"                                     #bashbud
