#!/bin/bash -e

#######################################################################
# Title      :    jether_menu.sh
# Author     :    Maximilian Schenk (max.schenk@gmx.net)
# Date       :    2018-26-01
# Version    :    1.1
#######################################################################
# Description
#   This script is optimized for mac.
#
#######################################################################

BACKTITLE="jether - Control Center for Ethereum based blockchain - V. $VERSION"

_temp="/tmp/answer.$$"
PN=`basename "$0"`
dialog 2>$_temp
DVER=$(cat $_temp | head -1)
MENU="MAIN"



setup_menu(){

MENU="SETUP"

  dialog --backtitle "$BACKTITLE"\
      --title " Setup "\
      --cancel-label "Quit" \
      --menu "Move using [UP] [DOWN], [Enter] to select" 20 60 8\
      Init "Genesis Block"\
      Copy "accounts to keystore"\
      Remove "'geth' folder from data dir"\
      Edit "$CONFIGFILE with nano"\
      D-Show "default config ($CONFIGFILE)"\
      P-Show "personal config ($PERSONAL_CONFIGFILE)"\
      Open "'data' folder ($ABS_DATADIR)"\
      Back "to main menu" 2>$_temp

    #  Genesis "Show Genesis Block ($GENESISBLOCK)"\

      opt=${?}
      if [ $opt != 0 ]; then back; fi
      menuitem=`cat $_temp`
      echo "menu=$menuitem"
      case $menuitem in
          Init) init;;
          Copy) copyaccounts;;
          Remove) remove;;
          Edit) nano "$CONFIG_DIR/$CONFIGFILE";;
          D-Show) textbox $CONFIGFILE;;
          P-Show) textbox $PERSONAL_CONFIGFILE;;
          Genesis) textbox $GENESISBLOCK;;
          Open) openDataDir;;
          Back) back;;
      esac
}


main_menu() {
  MENU="MAIN"

    dialog --backtitle "$BACKTITLE" --title " Main Menu"\
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


start_jether(){
  while true; do
    menu_select
  done
}
