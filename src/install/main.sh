#!/usr/bin/env bash

main(){

  this_dir="$___dir"
  bud_dir="$(git rev-parse --show-toplevel)"
  bpk_dir="$bud_dir/packages"
  sub_dir="$HOME/tmp/subba"
  sub_dir="$SUBLIME_DIR"
  pkg_dir="$sub_dir/Packages"
  inst_dir="$sub_dir/Installed Packages"
  usr_dir="$pkg_dir/User"
  loc_dir="$sub_dir/Local"
  fil_dir="$this_dir/files"

  local pc_pkg="$inst_dir/Package Control.sublime-package"

  # check if Package Control is installed
  [[ -f $pc_pkg ]] || {
    notify-send -u critical \
    "Package Control not installed."
    exit 1
  }

  # close sublime if it is open
  killall sublime_text

  bu_dir="$sub_dir/backup/$(cat /proc/sys/kernel/random/uuid)"

  # create backup of packages and licence file
  mkdir -p "$bu_dir/Local"
  mv -f "$inst_dir" "$bu_dir"
  mv -f "$pkg_dir" "$bu_dir"
  mv -f "$loc_dir/License.sublime_license" "$bu_dir/Local"

  # remove Localdir
  rm -rf "$loc_dir"

  # recreate Package dirs
  mkdir -p "$inst_dir"
  mkdir -p "$usr_dir"

  # restore license
  mv -f "$bu_dir/Local" "$sub_dir"

  # restore Package Control package
  mv -f -t "$inst_dir" \
    "$bu_dir/Installed Packages/Package Control.sublime-package" \
    "$bu_dir/Installed Packages/0_package_control_loader.sublime-package"

  mv -f -t "$usr_dir" "$bu_dir/Packages/User/"*ca-bundle

  # add mondo theme
  cp -rf "$bpk_dir/Mondo" "$pkg_dir"

  # add installation preferences
  cp -f "$fil_dir/"*settings "$usr_dir"
  
  # backup install workspace file
  cp -f "$fil_dir/install.sublime-workspace" "$fil_dir/wsbu"

  notify-send -u critical "$(printf '%s\n' \
    "Close sublime window when installation of all packages is done" \
    "to automaticly add all settings."
  )"

  subl "$fil_dir/install.sublime-workspace"
  subl -w "$usr_dir/Package Control.sublime-settings"

  echo "restore wsbu"
  # restore workspace file
  mv -f "$fil_dir/wsbu" "$fil_dir/install.sublime-workspace"

  # remove installation session
  rm -f "${sub_dir}/Local/"*.sublime_session

  # extract packages
  "${bud_dir}/scripts/subextract/main.sh" -fed -s "${bud_dir}/packages"

  # open sublime with sublime project
  subl "${usr_dir}/Projects/sublime.sublime-workspace"
  subl "${pkg_dir}/budlime/post-install.md"
}

___source="$(readlink -f "${BASH_SOURCE[0]}")"
___dir="${___source%/*}"                      
source "$___dir/init.sh"                        #bashbud
main "${@}"                                     #bashbud
