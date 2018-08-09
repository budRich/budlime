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

OPT_DIR="/opt/sublime_text/Packages"
GIT_DIR="$HOME/git/dox"

PKG_EXT="sublime-package"
CNF_EXT="sublime-settings"

main(){
  while getopts :vhcp:des:f option; do
    case "${option}" in
      f) force=1 ;;
      s) synksettings "${pkgsource:=$OPTARG}" ; exit ;;
      p) pkgsource="${OPTARG}" ;;
      c) cleaninstall=1 ;;
      d) blankdefaults=1 ;;
      e) extracteddeaults=1 ;;

      v) printf '%s\n' \
           "$NAME - version: $VERSION" \
           "updated: $UPDATED by $AUTHOR"
         exit ;;

      h|*) printinfo && exit ;;
    esac
  done

  ((cleaninstall==1)) && {
    BU_DIR="$SUB_DIR/backup/$(cat /proc/sys/kernel/random/uuid)"
    mkdir -p "$BU_DIR"
    [[ -d $PKG_DIR ]] && mv -f "$PKG_DIR" "$BU_DIR"
  }

  mkdir -p "${TMP_DIR}" "${USR_DIR}/Projects" "${DEF_DIR}" \
           "${DOC_DIR}/packages" "${PKG_DIR}" "${GIT_DIR}" \
           "${WIK_DIR}"

  [[ -d $pkgsource ]] && loopsource "$pkgsource"
  
  extractinstalled
  extractdefaults

  # remove TMP_DIR
  rm -rf "${TMP_DIR:?}"
  
}

synksettings(){
  [[ -d "$1" ]] || exit 1

  for f in "$1"/*; do
    [[ -d "$f" ]] && synksettings "$f" && continue
    [[ ${f,,} =~ readme.md$ ]] && continue
    dirname="${f#$pkgsource\/}"
    dirname="${dirname%/*}"
    lastdir="${dirname##*/}"

    { [[ $f =~ ${CNF_EXT}$ ]] && [[ $lastdir != zublime ]] ;} \
      && f2="${USR_DIR}/${f##*/}" \
      || f2="${PKG_DIR}/$dirname/${f##*/}"

    if ((force!=1)) && [[ -f "${f2}" ]] && [[ "${f}" -ot "${f2}" ]]; then
      printf '%s --> %s\n' "${f2}" "${f}"
      cp -f "${f2}" "${f}"
    else
      printf '%s --> %s\n' "${f}" "${f2}"
      cp -f "${f}" "${f2}"
    fi

  done
}

loopsource(){
  # CNF_EXT="sublime-settings"
  # move settings to usr dir
  for f in "$1"/*; do
    [[ -d "$f" ]] && loopsource "$f" && continue
    [[ ${f,,} =~ readme.md$ ]] && continue
    dirname="${f#$pkgsource\/}"
    dirname="${dirname%/*}"
    lastdir="${dirname##*/}"

    if [[ $f =~ ${CNF_EXT}$ ]] && [[ $lastdir != zublime ]]; then
      ((force==1)) \
        && cp -f "$f" "$USR_DIR" && continue \
        || cp "$f" "$USR_DIR" && continue
    else
      mkdir -p "${PKG_DIR}/$dirname"
      ((force==1)) \
        && cp -f "$f" "${PKG_DIR}/$dirname" \
        || cp "$f" "${PKG_DIR}/$dirname"
    fi
  done
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
      # unzip "$p" -d . "${reads}" "${conf}" "${keys}" > /dev/null 2>&1
      unzip "$p" -d . "${reads}" "${conf}" "${keys}"

      [[ -f $reads ]] && mv "$reads" "${DOC_DIR}/packages/$name.md"
      [[ -f $keys ]] && {
        mv "$keys" "${DEF_DIR}/$name.keymap"
        ((extracteddeaults==1)) && [[ ! -f "${PKG_DIR}/$name/${keys##*/}" ]] && {
          mkdir -p "${PKG_DIR}/$name"
          cp "${DEF_DIR}/$name.keymap" "${PKG_DIR}/$name/${keys##*/}"
        }
      }

      [[ -f $conf ]] && {
        cnfname="${conf##*/}"
        cnfname="${cnfname%.*}"
        [[ $name != "Package Control" ]] && [[ ${conf##*/} != Preferences.${CNF_EXT} ]] && {
          [[ -f "${USR_DIR}/${conf##*/}" ]] || cp "$conf" "${USR_DIR}"
          ((extracteddeaults==1)) && {
            mkdir -p "${PKG_DIR}/$name"
            ((blankdefaults==1)) \
              && echo "{}" > "${PKG_DIR}/$name/${conf##*/}" \
              || cp "${conf}" "${PKG_DIR}/$name/${conf##*/}"
          }
        }

        [[ ${conf##*/} = Preferences.${CNF_EXT} ]] \
          && mv "$conf" "${DEF_DIR}/$name.${CNF_EXT#sublime-}" \
          || mv "$conf" "${DEF_DIR}/$cnfname.${CNF_EXT#sublime-}"
      }
      rm -rf ./*
    )

  done
}

extractdefaults(){
    p="$OPT_DIR/Default.sublime-package"
    afil=()
    eval "$(unzip -l "$p" -x */* -x *.{todo,tmLanguage,tmPreferences,ini,mustache,ico,xml,disabled-sublime-syntax,bin,dictonary,sublimelinterrc,txt,py,gitignore,json,exe,cs,png,cur,resx,cpp,m,csproj,snk,pal,aco,gpl,sln,sh,css,html,log,ss,dockerignore,yml,svg,js,cfg} \
      | awk '{$1=$2=$3="";sub(/[[:space:]]*/,"",$0)
        if(/./ && $0 != "Name" && $0 != "----") {
          # if (/settings/) print "afil+=(\"" $0 "\")"
          if (/Preferences( [(]Linux[)])*.sublime-settings$/) print "afil+=(\"" $0 "\")"
          if (/Default( [(]Linux[)])*.sublime-keymap$/) print "afil+=(\"" $0 "\")"
          if (/Default( [(]Linux[)])*.sublime-mousemap$/) print "afil+=(\"" $0 "\")"
        }}')"


    rm -rf "${TMP_DIR:?}"/*
    

    unzip "$p" -d "${TMP_DIR}" "${afil[@]}"

    # copy stuff to defdir
    dprefs=(
      "${TMP_DIR}/Preferences.sublime-settings"
      "${TMP_DIR}/Preferences (Linux).sublime-settings"
    )

    dkeys=(
      "${TMP_DIR}/Default (Linux).sublime-keymap"
      "${TMP_DIR}/Default (Linux).sublime-mousemap"
    )


    for d in "${dprefs[@]}" "${dkeys[@]}"; do
      dnmn="${d##*/}"
      cp -f "$d" "${DEF_DIR}/${dnmn/sublime-/}"
    done

    ((extracteddeaults==1)) && {
      mkdir -p "${PKG_DIR}/zublime" "${PKG_DIR}/Default"
      # move default settings to zublime
      [[ -f ${PKG_DIR}/zublime/Preferences.sublime-settings ]] || awk '
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
      ' "${TMP_DIR}/Preferences.sublime-settings" > "${PKG_DIR}/zublime/Preferences.sublime-settings"

      # move default settings to user (autofile)
      [[ -f ${USR_DIR}/Preferences.sublime-settings ]] || awk '
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
      ' "${TMP_DIR}/Preferences.sublime-settings" > "${USR_DIR}/Preferences.sublime-settings"

      rm -f "${dprefs[@]}"

      ((blankdefaults==1)) \
          && echo "{}" | tee "${dprefs[@]}"

      mkdir -p "${PKG_DIR}/Default"
      
      for f in "${dprefs[@]}" "${dkeys[@]}"; do
        [[ -f "${PKG_DIR}/Default/${f##*/}" ]] || mv "$f" "${PKG_DIR}/Default"
      done
    }
    
    rm -rf "${TMP_DIR:?}"/*
}

printinfo(){
about='`subextract` - Creates a settings project as an alternative to the default sublime settings system.

SYNOPSIS
--------

`subextract` [`-v`|`-h`]  
`subextract` [`-c`] [`-d`] [`-e`] [`-f`] [`-p` PACKAGE_DIRECTORY]  
`subextract` [`-f`] [`-s` PACKAGE_DIRECTORY]  

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

`subextract` will also create a *sublime.sublime-project* file.


OPTIONS
-------

`-v`  
Show version and exit.

`-h`  
Show help and exit.

`-c`  
Clean install. Move the current *$PKG_DIR* to *$SUB_DIR/backup* before any other operations.  

`-p` PACKAGE_DIRECTORY  
Copy files withing *PACKAGE_DIRECTORY* before any other operations.  
Example:  

``` Text
~/tmp/MyPacks
  iOpener
    iOpener.sublime-settings
    Default.sublime-keymap
    random.file
    A-dir/
      picture.jpg
  A File Icon
    A File Icon.sublime-settings
    README.md
```  

Executing the following command:  
`$ subextract -p ~/tmp/MyPacks`  

Will result in this inside *$SUB_DIR*  

``` text
~/.config/sublime-text-3/Packages
  iOpener
    Default.sublime-keymap
    random.file
    A-dir/
      picture.jpg
  User
    iOpener.sublime-settings
    A File Icon.sublime-settings
```

Conclusion: all \*.sublime-settings will get copied to *$USR_DIR* and all other files,
(*with the exception for files named `README.md`*), will be copied to *$PKG_DIR* with
retained directory structure. It will not overwrite any existing files.

- - -

`-e`  
Extract packages default settingfiles to *$PKG_DIR*

`-d`  
Blank extraced default files. (only have effect if `-e` is used)

`-s` PACKAGE_DIRECTORY  
Sync files in *PACKAGE_DIRECTORY* with files in *$PKG_DIR*.
Works both ways, the newest file will overwrite the oldest.

`-f`  
Force files from PACKAGE_DIRECTORY to overwrite,
no matter if target file exists (`-p`) or is newer (`-s`).

FILES
-----

SUB_DIR - sublimes config directory.  
defaults to: *$HOME/.config/sublime-text-3*  

OPT_DIR - core package directory
defaults to: */opt/sublime_text/Packages*  

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
