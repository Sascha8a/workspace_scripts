#!/bin/bash

source $ROSWSS_BASE_SCRIPTS/helper/helper.sh

cd $ROSWSS_ROOT

if [ "$#" -eq 0 ]; then
  echo -ne "${YELLOW}Do you want to clean devel and build? [y/N] ${NOCOLOR}"
  read -N 1 REPLY
  echo
  if test "$REPLY" = "y" -o "$REPLY" = "Y"; then
    catkin clean --all --yes
    for dir in ${ROSWSS_SCRIPTS//:/ }; do
        if [ -f "$dir/clean_externals.sh" ]; then
            . $dir/clean_externals.sh
        fi
    done
    echo_info ">>> Cleaned devel and build directories."
  else
    echo_error ">>> Clean cancelled by user."
  fi
else 
  command=$1
  if [ $command == "externals" ]; then
    for dir in ${ROSWSS_SCRIPTS//:/ }; do
        if [ -f "$dir/clean_externals.sh" ]; then
            . $dir/clean_externals.sh
        fi
    done
  else
    catkin clean "$@"
  fi
fi
