#!/bin/bash -e

set -x
set -o pipefail

source scripts/jether_helper.sh
source scripts/jether_functions.sh
source scripts/jether_menu.sh

#######################################################################
# Title      :    jether.sh
# Author     :    Maximilian Schenk (max.schenk@gmx.net)
# Date       :    2007-11-02
# Version    :    1.1
#######################################################################
# Description
#   This script is optimized for mac.
#
# Setup
#
#   brew install dialog
#   brew install geth
#######################################################################

VERSION="1.1"

load_configuration
set_abolute_datadir

start_jether
