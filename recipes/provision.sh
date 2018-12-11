#!/usr/bin/env bash

# Base
if ! ${STEP_BASE_SYSTEM_DONE:-false} ; then # Avoid redundancy with other provisioning scripts
  bash "${RUNR_DIR:-.}"/recipes/apps.sh
  bash "${RUNR_DIR:-.}"/recipes/shell.sh
fi

# Desktop
if ! ${NODESKTOP:-false} ; then
  if (uname | grep -i -q linux) ; then
    if [[ $PROVISION_OPTIONS = *workstation* ]] ; then
      bash "${RUNR_DIR:-.}"/recipes/base-el7-gui.sh
      bash "${RUNR_DIR:-.}"/recipes/base-el7-gui-fonts.sh
      bash "${RUNR_DIR:-.}"/recipes/xfce.sh
      bash "${RUNR_DIR:-.}"/recipes/apps-el-desktop.sh
      bash "${RUNR_DIR:-.}"/installers/setupanki.sh
      bash "${RUNR_DIR:-.}"/installers/setupchrome.sh
      bash "${RUNR_DIR:-.}"/installers/setuprdp.sh xfce
    else
      bash "${RUNR_DIR:-.}"/recipes/xfce.sh
      bash "${RUNR_DIR:-.}"/recipes/apps-desktop.sh
    fi
  fi
  bash "${RUNR_DIR:-.}"/recipes/powerline-fonts.sh
  bash "${RUNR_DIR:-.}"/recipes/subl.sh
  bash "${RUNR_DIR:-.}"/recipes/vscode.sh
fi

# System
bash "${RUNR_DIR:-.}"/recipes/linux-fixes.sh

# Dev platforms
bash "${RUNR_DIR:-.}"/recipes/python.sh
bash "${RUNR_DIR:-.}"/installers/setuprust.sh

# Dev tools
bash "${RUNR_DIR:-.}"/installers/setupdocker.sh
bash "${RUNR_DIR:-.}"/installers/setupdocker-compose.sh
bash "${RUNR_DIR:-.}"/installers/setupexa.sh
bash "${RUNR_DIR:-.}"/installers/setupsdkman.sh
bash "${RUNR_DIR:-.}"/installers/setupvim.sh python3