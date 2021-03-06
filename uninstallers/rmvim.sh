#!/usr/bin/env bash

# Remove Vim from the system

# #############################################################################
# Globals

USAGE="[-p] option purges any config files remaining"
PURGE=false

export APTPROG=apt-get; which apt >/dev/null 2>&1 && export APTPROG=apt
export RPMPROG=yum; which dnf >/dev/null 2>&1 && export RPMPROG=dnf

# #############################################################################
# Options

OPTIND=1
while getopts ':hp' option ; do
  case "${option}" in
    h) echo "$USAGE"; exit;;
    p) PURGE=true;;
  esac
done
shift "$((OPTIND-1))"

# #############################################################################

# Remove Vim from the system

if egrep -i -q -r 'debian|ubuntu' /etc/*release ; then

  sudo $APTPROG remove -y --purge vim vim-runtime vim-gnome vim-tiny vim-gui-common

elif egrep -i -q -r 'centos|fedora|oracle|red *hat' /etc/*release ; then

  sudo $RPMPROG -y remove vim-enhanced
fi

sudo rm -frv /usr/{,local/}bin/vi{ew,m,mdiff,mtutor} /usr/{,local/}share/vim

# #############################################################################
# Purge

if ${PURGE:-false} ; then

  if egrep -i -q -r 'centos|fedora|oracle|red *hat' /etc/*release ; then

    for file in $(rpm -q --configfiles vim-enhanced)
    do
      echo "  removing $file"
      rm -f $file
    done
    rpm -e vim-enhanced
  fi
fi

# #############################################################################
