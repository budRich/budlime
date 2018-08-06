#!/bin/bash

NAME="subextract"
VERSION="0.001"
AUTHOR="budRich"
CONTACT='robstenklippa@gmail.com'
CREATED="2018-08-05"
UPDATED="2018-08-05"

SUB_DIR="$HOME/.config/sublime-text-3"
TMP_DIR="/tmp/subextract"
ZIP_DIR="$SUB_DIR/Installed Packages"
PKG_DIR="$SUB_DIR/Packages"
USR_DIR="$PKG_DIR/User"
DOC_DIR="$USR_DIR/dox"
DEF_DIR="$DOC_DIR/defaults"
WIK_DIR="$DOC_DIR/wiki"
OPT_DIR="/opt/sublime_text/Packages"
GIT_DIR="$HOME/git/dox"

declare -A wikis
wikis[linter]="https://github.com/SublimeLinter/SublimeLinter.git"
wikis[sublime]="https://github.com/guillermooo/sublime-undocs.git"

PKG_EXT="sublime-package"
CNF_EXT="sublime-settings"

main(){
  while getopts :vh option; do
    case "${option}" in
      v) printf '%s\n' \
           "$NAME - version: $VERSION" \
           "updated: $UPDATED by $AUTHOR"
         exit ;;
      h|*) printinfo && exit ;;
    esac
  done

  mkdir -p "${TMP_DIR}" "${USR_DIR}/Projects" "${DEF_DIR}" \
           "${DOC_DIR}/packages" "${PKG_DIR}" "${GIT_DIR}" \
           "${WIK_DIR}"

  preparewikis
  extractdefaults
  extractinstalled
  createprojectfile

  # remove TMP_DIR
  rm -rf "${TMP_DIR:?}"
  
}

createprojectfile(){
  projectfile="${USR_DIR}/Projects/sublime.sublime-project"

  [[ -f $projectfile ]] || echo "{
  \"folders\":
  [
    { 
      \"path\": \"${PKG_DIR/$HOME/'~'}/zublime\",
      \"name\": \"User - settings\"
    },
    { 
      \"path\": \"${PKG_DIR/$HOME/'~'}/Default\",
      \"name\": \"Default - settings\"
    },
    { 
      \"path\": \"${USR_DIR/$HOME/'~'}\",
      \"name\": \"Package - settings\",
      \"folder_exclude_patterns\": [\"dox\",\"Package Control.cache\",\"Projects\"],
      \"file_exclude_patterns\": [\"*.last-run\",\"*-ca-bundle\"],
    },
    { 
      \"path\": \"${PKG_DIR/$HOME/'~'}/DA UI\",
      \"name\": \"UI - settings\",
      \"folder_exclude_patterns\": [\"*\"],
      \"file_exclude_patterns\": [
        \"*.json\",
        \"Widget - DA (*\",
        \".version\",
        \".no-sublime-package\"
      ],
    },
    { 
      \"path\": \"${USR_DIR/$HOME/'~'}/Projects\",
      \"name\": \"Project - settings\",
      \"file_include_patterns\": [\"*.sublime-project\"]
    },
    { 
      \"path\": \"${DOC_DIR/$HOME/'~'}\",
      \"name\": \"dox\"
    },
    { 
      \"path\": \"${PKG_DIR/$HOME/'~'}\",
      \"name\": \"packages-extracted\",
      \"folder_exclude_patterns\": [\"User\",\"zublime\",\"DA UI\"],
    },
    { 
      \"path\": \"${SUB_DIR/$HOME/'~'}/Installed Packages\",
      \"name\": \"packages-installed\",
      \"binary_file_patterns\": [\"*.sublime-package\"]
    },
    { 
      \"path\": \"${OPT_DIR}\",
      \"name\": \"packages-opt\",
      \"binary_file_patterns\": [\"*.sublime-package\"]
    },
  ]
}" > "$projectfile"
}

extractinstalled(){
  for p in "$ZIP_DIR/"*."${PKG_EXT}"; do

    name="${p##*/}"
    name="${name%.*}"

    keys=""
    conf=""
    reads=""

    eval "$(unzip -l "$p" -x */* -x *.{todo,tmLanguage,tmPreferences,ini,mustache,ico,xml,disabled-sublime-syntax,bin,dictonary,sublimelinterrc,txt,py,gitignore,json,exe,cs,png,cur,resx,cpp,m,csproj,snk,pal,aco,gpl,sln,sh,css,html,log,ss,dockerignore,yml,svg,js,cfg} \
      | awk '{$1=$2=$3="";sub(/[[:space:]]*/,"",$0)
        if(/./ && $0 != "Name" && $0 != "----") {
          if (/sublime-settings$/) print "conf=\"" $0 "\""
          if (/Default( [(]Linux[)])*.sublime-keymap$/) print "keys=\"" $0 "\""
          if (tolower($0) == "readme.md") print "reads=\"" $0 "\""
        }}')"
    
    (
      cd "${TMP_DIR}" || exit 1
      unzip "$p" -d . "${reads}" "${conf}" "${keys}"

      [[ -f $reads ]] && mv "$reads" "${DOC_DIR}/packages/$name.md"
      [[ -f $keys ]] && {
        cp "$keys" "${DEF_DIR}/$name.sublime-keymap"
        mkdir -p "${PKG_DIR}/$name"
        mv "$keys" "${PKG_DIR}/$name/$keys"
      }

      [[ -f $conf ]] && {
        [[ $name != "Package Control" ]] && {
          cp "$conf" "${USR_DIR}"
          mkdir -p "${PKG_DIR}/$name"
          echo "{}" > "${PKG_DIR}/$name/$conf"
        }

        mv "$conf" "${DEF_DIR}"
      }
    )

  done
}

preparewikis(){

  for w in "${!wikis[@]}"; do
    [[ -d "$GIT_DIR/$w" ]] \
      || git clone "${wikis[$w]}" "$GIT_DIR/$w"
    if [[ $w = linter ]]; then

      eval "$(rstcrawl "$GIT_DIR/$w/docs" \
        | awk -v wdir="$WIK_DIR/$w" -v base="$GIT_DIR/$w/docs" '{
        full=$0
        sub(base"/","",$0)
        fil=$0
        sub(/\/.*$/,"",$0)
        dir=$0
        if (fil==dir) {dir=""}
        print "mkdir -p " wdir "/" dir
        print "cp -f " full " " wdir "/" dir
      }')"

    elif [[ $w = sublime ]]; then
      eval "$(rstcrawl "$GIT_DIR/$w/source" \
        | awk -v wdir="$WIK_DIR/$w" -v base="$GIT_DIR/$w/source" '{
        full=$0
        sub(base"/","",$0)
        fil=$0
        sub(/\/.*$/,"",$0)
        dir=$0
        if (fil==dir) {dir=""}
        print "mkdir -p " wdir "/" dir
        print "cp -f " full " " wdir "/" dir
      }')"
    fi
  done
}

rstcrawl(){
  for f in "${1}/"*; do
    [[ -d $f ]] && rstcrawl "$f" && continue
    [[ ${f##*.} = rst ]] || continue
    echo "$f"
  done
}

extractdefaults(){
    p="$OPT_DIR/Default.sublime-package"
    eval "$(unzip -l "$p" -x */* -x *.{todo,tmLanguage,tmPreferences,ini,mustache,ico,xml,disabled-sublime-syntax,bin,dictonary,sublimelinterrc,txt,py,gitignore,json,exe,cs,png,cur,resx,cpp,m,csproj,snk,pal,aco,gpl,sln,sh,css,html,log,ss,dockerignore,yml,svg,js,cfg} \
      | awk '{$1=$2=$3="";sub(/[[:space:]]*/,"",$0)
        if(/./ && $0 != "Name" && $0 != "----") {
          # if (/settings/) print "afil+=(\"" $0 "\")"
          if (/Preferences( [(]Linux[)])*.sublime-settings$/) print "afil+=(\"" $0 "\")"
          if (/Default( [(]Linux[)])*.sublime-keymap$/) print "afil+=(\"" $0 "\")"
          if (/Default( [(]Linux[)])*.sublime-mousemap$/) print "afil+=(\"" $0 "\")"
        }}')"
    (
      cd "${PKG_DIR}" || exit 1
      mkdir -p zublime
      mkdir -p Default && cd Default
      unzip "$p" -d . "${afil[@]}"

      # move default settings to zublime
      [[ -f ../zublime/Preferences.sublime-settings ]] || awk '
        BEGIN{fndblk=0}

        /^[}]/ {exit}
        start==1 && /./ {blk[fndblk]=blk[fndblk] "\n" $0}
        start==1 && $0 !~ /./ {fndblk++}
        $1 ~ "font_options|theme_font_options|color_scheme|font_face|font_size|ignored_packages" {ignore[fndblk]=1}
        /^[{]/ {start=1}

        END{
          print "{"
          for (b in blk){
            keep=1
            for (i in ignore) {
              if (i==b){keep=0}
            }
            if (keep==1)print blk[b]
          }
          print "}"
        }
      ' Preferences.sublime-settings > ../zublime/Preferences.sublime-settings

      # move default settings to zublime
      [[ -f ../User/Preferences.sublime-settings ]] || awk '
        BEGIN{fndblk=0}

        /^[}]/ {exit}
        start==1 && /./ {blk[fndblk]=blk[fndblk] "\n" $0}
        start==1 && $0 !~ /./ {fndblk++}
        $1 ~ "font_options|theme_font_options|color_scheme|font_face|font_size|ignored_packages" {ignore[fndblk]=1}
        /^[{]/ {start=1}

        END{
          print "{"
          for (b in blk){
            keep=1
            for (i in ignore) {
              if (i==b){keep=0}
            }
            if (keep==0)print blk[b]
          }
          print "}"
        }
      ' Preferences.sublime-settings > ../User/Preferences.sublime-settings
      
      rm Preferences.sublime-settings
      # blank defaults
      echo "{}" | tee Preferences.sublime-settings "Preferences (Linux).sublime-settings"
      
      # create blank keymap file in zublime
      [[ -f ../zublime/Default.sublime-keymap ]] || echo -e "{\n\n}" > ../zublime/Default.sublime-keymap
    )
}

printinfo(){
about='`subextract` - Creates a settings project as an alternative to the default sublime settings system.

SYNOPSIS
--------

`subextract` [`-v`|`-h`]

DESCRIPTION
-----------

`subextract` extracts files from installed packages and creates a project file
that is intended to be a better alternative to sublimes default settings system.

`subextract` will extract all *readme.md* files from all installed packages, and
move the readme to the directory $USR_DIR/dox/packages, where the files will be renamed
to: *package-name.md*. Any *sublime-settings*,*sublime-keymap* and *sublime-mousemap* files
found in the archived packages will get moved and renamed (*if needed*) to *$USR_DIR/dox/packages*.  

*sublime-settings* will also get copied to $USR_DIR if the file doesn'"'"'t already exist there.

`subextract` will also create a directory with the package name inside $PKG_DIR .
(*files in this directory will overwrite the same files in the __packed__ version of the package.*).
`subextract` will add blank *sublime-settings*, in these directories. 

The thought of this is to only have one settings file (*user*) as opposed to two (read-only default and user),
as is the default behaviour of sublime. One advantage of this is that it is easier to
f.i. disable a default keybinding. And all default settings are backed up as described above,
in case something breaks.  

`subextract` will also do this with the *Default* **core** package (*/opt/sublime_text/Packages/Default.sublime-package*),
and put the *user* settings inside the directory: *$PKG_DIR/zublime*. The reason for this is
that sublime removes all comments and empty lines and auto sort, *$PKG_DIR/User/default.sublime-settings*, 
when the settings are updated (when f.i. the user changes the theme from the command palette.).

`subextract` will clone two GitHub repositories that contain the unofficial sublime documentation
and `SublimeLinter`s documentation, and copy the documentation to *$USR_DIR/dox/wiki*.

`subextract` will also create a *sublime.sublime-project* file.


OPTIONS
-------

`-v`  
Show version and exit.

`-h`  
Show help and exit.


FILES
-----

SUB_DIR - sublimes config directory.  
defaults to: *$HOME/.config/sublime-text-3*  

TMP_DIR - temporary directory where package files get extracted to.  
defaults to: */tmp/subextract*  

ZIP_DIR - installed (*packed*) packages directory.  
defaults to: *$SUB_DIR/Installed Packages*  

PKG_DIR - (*unpacked*) packages directory.   
defaults to: *$SUB_DIR/Packages*  

USR_DIR - User package directory.  
defaults to: *$PKG_DIR/User*  

DOC_DIR - directory where readmes and wikis are stored.  
defaults to: *$USR_DIR/dox*  

DEF_DIR - directory where default config files are backed up.  
defaults to: *$DOC_DIR/defaults*  

WIK_DIR - directory where the documentation from the cloned repos will be stored.   
defaults to: *$DOC_DIR/wiki*  

OPT_DIR - core package directory
defaults to: */opt/sublime_text/Packages*  

GIT_DIR - where to store the cloned repos.
defaults to: *$HOME/git/dox*  

$USR_DIR/projects/*sublime.sublime-project*  
project file.  


DEPENDENCIES
------------

unzip  
Sublime Text  
'

bouthead="
${NAME^^} 1 ${CREATED} Linux \"User Manuals\"
=======================================

NAME
----
"

boutfoot="
AUTHOR
------

${AUTHOR} <${CONTACT}>
<https://budrich.github.io>

SEE ALSO
--------

unzip(1)
"


  case "$1" in
    m ) printf '%s' "${about}" ;;
    
    f ) 
      printf '%s' "${bouthead}"
      printf '%s' "${about}"
      printf '%s' "${boutfoot}"
    ;;

    ''|* ) 
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

ERR(){ >&2 echo "[WARNING]" $@; }
ERX(){ >&2 echo "[ERROR]" $@ && exit 1 ; }

if [ "$1" = "md" ]; then
  printinfo m
  exit
elif [ "$1" = "man" ]; then
  printinfo f
  exit
else
  main "${@}"
fi
