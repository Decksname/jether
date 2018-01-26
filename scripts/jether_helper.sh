#!/bin/bash -e

#######################################################################
# Title      :    jether_helper.sh
# Author     :    Maximilian Schenk (max.schenk@gmx.net)
# Date       :    2018-26-01
# Version    :    1.1
#######################################################################
# Description
#   This script is optimized for mac.
#
#######################################################################

CONFIG_DIR="config"
CONFIGFILE="default_jethereum.cfg"
PERSONAL_CONFIGFILE="personal_jethereum.cfg"

load_configuration(){
source "$CONFIG_DIR/$CONFIGFILE"

local p_config="$CONFIG_DIR/$PERSONAL_CONFIGFILE"

if [ -f $p_config ];
  then
    source $p_config
    CONFIG_SOURCE_PERSONAL=true
  else
    echo "No personal configuration file found. ($p_config)"
    CONFIG_SOURCE_PERSONAL=false
  fi
}


set_abolute_datadir(){
# define absolute datadir
if $CONFIG_SOURCE_PERSONAL; then
  ABS_DATADIR=$DATADIR
else
    cd "$DATADIR"
    current_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
    ABS_DATADIR=$current_dir
fi

# check if absolute datadir exists
if [ ! -d $ABS_DATADIR ]; then
    echo ERROR: "Data Dir ($ABS_DATADIR) does not exist"
    exit 1 # terminate and indicate error
fi
}
