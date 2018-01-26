#!/bin/bash -e

#######################################################################
# Title      :    jether_functions.sh
# Author     :    Maximilian Schenk (max.schenk@gmx.net)
# Date       :    2018-26-01
# Version    :    1.1
#######################################################################
# Description
#   This script is optimized for mac.
#
#######################################################################

init(){
  local genesis="$CONFIG_DIR/$GENESISBLOCK"
  geth --datadir $ABS_DATADIR init $genesis;
  dialog --msgbox "Genesis Block has been initialized at\n$ABS_DATADIR" 6 42
}

copyaccounts(){
  local count=$(ls -1q accounts/* | wc -l)
  cp accounts/* $ABS_DATADIR/keystore/
  dialog --msgbox "$count accounts have been copied" 6 42

}

remove(){
  local GETHDIR="$ABS_DATADIR/geth"
  rm -rf $GETHDIR
  dialog --msgbox "$GETHDIR has been removed" 6 42
}

version() {
    dialog --backtitle "$BACKTITLE" \
           --msgbox "$PN - Version $VERSION\nMaximilian Schenk (max.schenk@gmx.net)" 9 52
}

node(){
  geth --datadir $ABS_DATADIR \
  --networkid $CHAINID \
  --port $OWNPORT \
  --bootnodesv4 $ENODE$V4PORT \
  --bootnodesv5 $ENODE$V5PORT \
  --verbosity 3
}

mining(){
  geth --datadir $ABS_DATADIR \
  --networkid $CHAINID  \
  --port $OWNPORT \
  --bootnodesv4 $ENODE$V4PORT \
  --bootnodesv5 $ENODE$V5PORT \
  --mine \
  --minerthreads $THREADSFORMINING \
  --etherbase $ACCOUNT
}

wallet(){
  "$APP_ETHEREUMWALLET" --rpc $IPC;
}

mist(){
  $APP_MIST --rpc $IPC --swarmurl null;
}

attach(){
  geth attach $IPC;
}

textbox() {
  local file="$CONFIG_DIR/$1"
    if [ -e $file ]; then
        dialog --backtitle "$file"\
               --begin 3 5 --title "use [up] [down] to scroll "\
               --textbox $file 20 70
    else
        dialog --msgbox "*** ERROR ***\n$file does not exist" 6 42
    fi
}

back(){
  MENU="MAIN"
}

openDataDir(){
  cd $ABS_DATADIR
  open .
}
