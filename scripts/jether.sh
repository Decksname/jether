#!/bin/bash -e

set -x
set -o pipefail


#######################################################################
# Title      :    jether.sh
# Author     :    Maximilian Schenk (max.schenk@gmx.net)
# Date       :    2007-11-02
# Version    :    1.0
#######################################################################
# Description
#   This script is optimized for mac.
#
# Setup
#
#   brew install dialog
#   brew install geth
#######################################################################

VERSION="1.0"
BACKTITLE="jether - Control Center for Ethereum based blockchain"

CONFIGFILE="default_jethereum.cfg"
PERSONAL_CONFIGFILE="personal_jethereum.cfg"


source $CONFIGFILE

if [ -f $PERSONAL_CONFIGFILE ];
  then
    source $PERSONAL_CONFIGFILE
  else
    echo"No personal configuration file found. ($PERSONAL_CONFIGFILE)"
fi

_temp="/tmp/answer.$$"
PN=`basename "$0"`
dialog 2>$_temp
DVER=$(cat $_temp | head -1)
MENU="MAIN"

init(){
  geth --datadir $DATADIR init $GENESISBLOCK;
  dialog --msgbox "Genesis Block has been initialized at\n$DATADIR" 6 42
}

copyaccounts(){
  local count=$(ls -1q accounts/* | wc -l)
  cp accounts/* $DATADIR/keystore/
  dialog --msgbox "$count accounts have been copied" 6 42

}

remove(){
  local GETHDIR="$DATADIR/geth"
  rm -rf $GETHDIR
  dialog --msgbox "$GETHDIR has been removed" 6 42
}

version() {
    dialog --backtitle "$BACKTITLE" \
           --msgbox "$PN - Version $VERSION\nMaximilian Schenk (max.schenk@gmx.net)" 9 52
}

node(){
  geth --datadir $DATADIR \
  --networkid $CHAINID \
  --port $OWNPORT \
  --bootnodesv4 $ENODE$V4PORT \
  --bootnodesv5 $ENODE$V5PORT \
  --verbosity 3
}

mining(){
  geth --datadir $DATADIR \
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
    if [ -e $1 ]; then
        dialog --backtitle "$1"\
               --begin 3 5 --title "use [up] [down] to scroll "\
               --textbox $1 20 70
    else
        dialog --msgbox "*** ERROR ***\n$1 does not exist" 6 42
    fi
}

back(){
  MENU="MAIN"
}

openDataDir(){
  cd $DATADIR
  open .
}

setup_menu(){

MENU="SETUP"

  dialog --backtitle "$BACKTITLE"\
      --title " Control Center - V. $VERSION "\
      --cancel-label "Back" \
      --menu "Move using [UP] [DOWN], [Enter] to select" 20 60 8\
      Init "Initialize Genesis Block"\
      Copy "Copy accounts to keystore"\
      Remove "Remove 'geth' folder from data dir"\
      Edit "Edit $CONFIGFILE with nano"\
      Show "Show configuration ($CONFIGFILE)"\
      Open "Opens $DATADIR"\
      Back "Back to main menu" 2>$_temp

    #  Genesis "Show Genesis Block ($GENESISBLOCK)"\

      opt=${?}
      if [ $opt != 0 ]; then back; fi
      menuitem=`cat $_temp`
      echo "menu=$menuitem"
      case $menuitem in
          Init) init;;
          Copy) copyaccounts;;
          Remove) remove;;
          Edit) nano $CONFIGFILE;;
          Show) textbox $CONFIGFILE;;
          Genesis) textbox $GENESISBLOCK;;
          Open) openDataDir;;
          Back) back;;
      esac
}


main_menu() {
  MENU="MAIN"

    dialog --backtitle "$BACKTITLE" --title " Main Menu - V. $VERSION "\
        --cancel-label "Quit" \
        --menu "Move using [UP] [DOWN], [Enter] to select" 20 60 8\
        Wallet "Start Ethereum Wallet"\
        Mist "Start Mist"\
        Node "Start Node"\
        Mining "Start Mining Node"\
        Attach "Attach to geth IPC"\
        Setup "Setup your local chain"\
        Version "Show program version info"\
        Quit "Exit the program" 2>$_temp

    opt=${?}
    if [ $opt != 0 ]; then rm $_temp; exit; fi
    menuitem=`cat $_temp`
    echo "menu=$menuitem"
    case $menuitem in
        Version) version;;
        Attach) attach;;
        Wallet) wallet;;
        Mist) mist;;
        Node) node;;
        Setup) setup_menu;;
        Mining) mining;;
        Quit) exit;;
    esac
}

menu_select(){
  echo "Selected Menu = $MENU"
  if [ "$MENU" == "MAIN" ]
then
  main_menu
else
  setup_menu
fi
}


while true; do
  menu_select
done
