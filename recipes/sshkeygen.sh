#!/usr/bin/env bash

# Create a default SSH key

PROGNAME=sshkeygen.sh
SCRIPT_DIR="$(dirname "${0%/*}")"
SCRIPT_DIR="${SCRIPT_DIR:-$(pwd)}"

# #############################################################################
# Helpers

_print_bar () {
  echo "################################################################################"
}

_print_header () {
  echo "################################################################################"
  echo "$@"
  echo "################################################################################"
}

# #############################################################################
_print_header "SSH RSA key"

if [ ! -e "${DS_HOME:-$HOME/.ds}/ds.sh" ] ; then
  ./installers/setupds.sh
fi
if [ ! -e "${DS_HOME:-$HOME/.ds}/ds.sh" ] ; then
  echo "${PROGNAME:+$PROGNAME: }FATAL: No Daily Shells directory available." 1>&2
  exit 1
fi
"${DS_HOME:-$HOME/.ds}"/scripts/sshkeygenrsa.sh

# #############################################################################
_print_bar

