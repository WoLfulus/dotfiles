#!/usr/bin/env bash

# ##############################################################################
# Helpers

_is_gui_env () {
  (which startx || which firefox || which google-chrome || which subl) >/dev/null 2>&1
}

# ##############################################################################
# Headless configs

cp -v ./conf/exrc ~/.exrc
cp -v ./conf/vimrc ~/.vimrc
cp -v ./conf/sshconfig ~/.ssh/config

# ##############################################################################
# GUI envs from this point on...

_is_gui_env || return 0 || exit 0

# ##############################################################################
# Prep Sublime Text User PATH

SUBL_WIN='C:\Users\cr391577\AppData\Roaming\Sublime Text 3'

if [[ "$(uname -a)" = *[Cc]ygwin* ]]; then
  if [ -d "`cygpath "${SUBL_WIN}"`" ] ; then
    SUBL_USER="${SUBL_WIN}/Packages/User"
  elif [ -d "/cygdrive/c/opt/subl" ] ; then
    SUBL_USER="/cygdrive/c/opt/subl/Data/Packages/User"
  else
    echo "Sublime path:"
    read SUBL_PATH
    SUBL_USER="${SUBL_PATH}/Data/Packages/User"
  fi
elif [[ "$(uname -a)" = *[Ll]inux* ]] ; then
  SUBL_USER="$HOME/.config/sublime-text-3/Packages/User"
fi

# ##############################################################################
# Sublime Text

mkdir -p "${SUBL_USER}"

if [ -f "${SUBL_USER}/Preferences.sublime-settings" ] ; then

  # Do not overwrite settings

  files="$(ls -1d ./conf/sublime3/* \
    | grep -F -v Preferences.sublime-settings \
    | sed "s/^/'/" \
    | sed "s/$/'/" \
    | tr '\n' ' ')"

else

  files="$(ls -1d ./conf/sublime3/* \
    | sed "s/^/'/" \
    | sed "s/$/'/" \
    | tr '\n' ' ')"
fi

eval cp -v "${files}" "${SUBL_USER}"/

# ##############################################################################
