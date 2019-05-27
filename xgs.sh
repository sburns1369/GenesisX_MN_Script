#!/bin/bash
#script_Version:1.3
#This script work was created by SBurns of the Null Entry Project
#And possible follow/fork from https://github.com/sburns1369/
#If anyone recycles please leave credit to the author somewhere
#As well as the donation address for the “Buy the poor guy a red bull”
#BTC address: 32FzghE1yUZRdDmCkj3bJ6vJyXxUVPKY93
#LTC address: MUdDdVr4Az1dVw47uC4srJ31Ksi5SNkC7H
#This script work is still in active deployment so please keep an eye June releases 2019
declare -i NC DEV DEVC DEVOld DEVMN0 DEVMN1 DEVMN2 DEVMN3 DEVMN4 DEVMN5 DEVMN6 DEVMN7 DEVMN8
#Counter
NC=0
#Coin MN found 0 false 1 true
DEV=0
#Masternode Counter
DEVC=0
#Coinname Lowercase
COINl=genesisx
#Coin ticket symbol
COIN3=XGS
COIN3l=xgs
COINDAEMON=genesisxd
COINDAEMONCLI=genesisx-cli
COINCORE=.genesisx
COINCONFIG=genesisx.conf
COINHOME=/home/genesisx
#wallet downnload and extractions commands
DOWNLOADCOINFILES=https://github.com/genesis-x/genesis-x/files/2799605/genesisx-linux.zip
COINFILES=genesisx-linux.zip
DECOMPRESS='unzip'
#rocketstrap
NEBootStrap=http://nullentry.com/chain/XGS/rocketstrap.rar
AddNodeList=http://nullentry.com/chain/XGS/addnodes.tbl
ADDNODE0=66.42.113.222:5555
ADDNODE1=108.61.179.198:5555
ADDNODE2=206.189.227.156:5555
ADDNODE3=155.138.207.17:5555
ADDNODE4=5.189.163.30:5555
ADDNODE5=213.227.154.56:5555
ADDNODE6=23.106.215.65:5555
ADDNODE7=155.138.207.17:5555
ADDNODE8=45.76.3.217:5555
ADDNODE9=8.12.18.113:5555
COINPORT=5555
COINRPCPORT=19021
#path to NullEntryDev stuff
DPATH=/usr/local/nullentrydev/
#IPCHECK
REGEX4='^([0-9]{0,3}:){1,7}[0-9a-fA-F]{0,4}$'
REGEX6='^([0-9a-fA-F]{0,4}:){1,7}[0-9a-fA-F]{0,4}$'
BLUE='\033[0;96m'
GREEN='\033[0;92m'
RED='\033[0;91m'
YELLOW='\033[0;93m'
CLEAR='\033[0m'
#Pause
pause(){
  read -p "Press [Enter] key to continue..." fackEnterKey
}
Test_Pause(){
  read -p "Testing Pause - Report if you see this - Press [Enter] key to continue..." fackEnterKey
}

#Null Entry logo
Function_Display_Null_Logo(){
bash <(curl -Ls https://raw.githubusercontent.com/sburns1369/GenesisX_MN_Script/master/null_logo.sh)
pause
}
#genesisx_Logo
Function_Display_Genesisx_Logo(){
  bash <(curl -Ls https://raw.githubusercontent.com/sburns1369/GenesisX_MN_Script/master/logo.sh)
  pause
  }
#Logo(){
Function_Rocket_Delay(){
bash <(curl -Ls https://raw.githubusercontent.com/sburns1369/GenesisX_MN_Script/master/rocket.sh)
}
  ### Start - First Run Configuration
  Function_Check_First_Run(){
  local NULLREC
  if grep -Fxq "${COIN3}firstrun_complete: true" /usr/local/nullentrydev/mnodes.log
    then
      echo "Not First Run"
    else
  bash <(curl -Ls https://raw.githubusercontent.com/sburns1369/GenesisX_MN_Script/master/welcome.sh)
  read  -p "Enter choice : " NULLREC
  case $NULLREC in
    y) function_first_run ;;
    Y) function_first_run ;;
    n) exit 0 ;;
    N) exit 0 ;;
    *) echo -e "${RED}Error...${STD}" ${CLEAR} && sleep 2 && Function_Check_First_Run
  esac
  fi
  }

  #Main menu
  Function_Show_Main_Menu() {
  cd ~
  clear
  echo
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo "             M A I N - M E N U"
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e "1 -  My Masternode(s) Status"
  echo -e "2 -  Install or Add Masternodes"
  echo -e "3 -  Masternode Manager"
  echo -e "4 -  Display Masternode.conf Information"
  echo -e "5 -  Donate"
  echo -e "6 -  Maintenance Manager"
  echo -e "X -  Exit"
  Function_Read_Main_Menu_Options
  }

  # root menu - read options
  Function_Read_Main_Menu_Options(){
  local choice
  read -p "Enter choice : " choice
  case $choice in
    1) Find_All_Masternodes ;;
    2) function_masternode_upgrade ;;
    3) Function_Manager_XGSMasternodes;;
    4) Function_Display_MasternodeConf;;
    5) function_Donations ;;
    6) Function_Manager_Maintenance_Menu ;;
    x) exit 0;;
    *) echo -e "${RED}Error...${STD}" ${CLEAR} && sleep 2
  esac
  }

  Function_Start_Masternode(){
  if [ -d /home/${COINl}${nodeunit} ]; then
    echo -e ${GREEN}"Starting Masternode ${nodeunit}" ${CLEAR}
    echo -e "Please wait" ${YELLOW}
    ${COINDAEMON} -datadir=${COINHOME}${nodeunit}/${COINCORE} -daemon
    sleep 15
    echo -e ${CLEAR}
  fi
  }

  Function_Stop_Masternode(){
    echo
  if [ -d /home/${COINl}${nodeunit} ]; then
    echo -e ${GREEN}"Stopping Masternode ${nodeunit}" ${YELLOW}
    ${COINDAEMONCLI} -datadir=${COINHOME}${nodeunit}/${COINCORE} stop
    sleep 7
    echo -e ${CLEAR}
  fi
  }

  #edit Masternode Configuration
  edit_masternode(){
  echo -e ${GREEN}"Editing Masternode ${nodeunit} Configuration" ${CLEAR}
  echo -e ${YELLOW}"Use [Control Key] + [X Key] to exit editting" ${CLEAR}
  echo -e ${YELLOW}"Press [N Key] to Abort Changes in editor" ${CLEAR}
  echo -e ${YELLOW}"Or press [Y Key] to Save Changes" ${CLEAR}
  echo -e ${YELLOW}"Than [Enter Key] to Accept Changes to File Name" ${CLEAR}
  pause
  nano ${COINHOME}${nodeunit}/${COINCORE}/${COINCONFIG}
  echo -e ${CLEAR}
  }

  Function_ViewCat_masternode(){
  clear
  cat ${COINHOME}${nodeunit}/${COINCORE}/${COINCONFIG}
  echo
  pause
  }

  # Function_Manager_XGSMasternodes menu
  Function_Manager_XGSMasternodes(){
  clear
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo "        Displaying Masternode Status"
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e "1 -  Display Masternode Information"
  echo -e "2 -  View Masternode Configuration"
  echo -e "3 -  Start Masternode(s)"
  echo -e "4 -  Stop Masternode(s)"
  echo -e "5 -  Re-Index Masternode(s)"
  echo -e "B-   Back - Previous Menu"
  echo -e "X -  Exit"
  Function_Read_Manager_XGSMasternodes
  }

  # manager_XGSMasternodes read options
  Function_Read_Manager_XGSMasternodes(){
  local choice
  read -p "Enter choice " choice
  case $choice in
    1) display_MN_Status ;;
    2) Function_View_Masternode_Config_Menu ;;
    3) manager_Start_Masternodes ;;
    4) manager_stop_Masternodes ;;
    5) function_menu_Reindex_Masternodes ;;
    b) echo ;;
    B) echo ;;
    x) exit 0;;
    X) exit 0;;
    *) echo -e "${RED}Error...${STD}" ${CLEAR} && sleep 2
  esac
  }

  #Start - Function_Manager_Maintenance_Menu menu
  Function_Manager_Maintenance_Menu(){
  clear
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo " Displaying Maintainance Options"
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e "1  -  Update Wallet"
  echo -e "2  -  Edit Masternode Configuration"
  echo -e "3  -  Glances - See System Resources"
  echo -e "4  -  Remove NullEntry Manager Script Files"
  echo -e "B  -  Back - Previous Menu"
  echo -e "X  -  Exit Program"
  Function_Read_Manager_Maintenance_Menu
  }

  #Start - manager_maintenance read options
  Function_Read_Manager_Maintenance_Menu(){
  local choice
  read -p "Enter choice " choice
  case $choice in
    1) stop_All_Nodes
    download_coinfiles
    Function_Start_All_Nodes
    echo "Wallet Update should be complete"
    pause ;;
    2) Edit_MN_Status ;;
    3) Function_Glances;;
    4) Function_Remove_Manager_Files;;
    b) echo ;;
    B) echo ;;
    x) exit 0;;
    X) exit 0;;
    *) echo -e "${RED}Error...${STD}" ${CLEAR} && sleep 2
  esac
  }

#Delete NullEntry Manager Files
Function_Remove_Manager_Files(){
local choice
clear
echo
echo
echo
echo -e "${RED} Press [ Y ] for Yes to delete all Null Entry Masternode Manger Files.  This will not impact Masternodes Installed"
echo -e "${YELLOW} Files will be re-built next time the script is ran.  This is the option you want to repair, redo legacy"
echo -e "${YELLOW} installations, or simply have no use for the Script Manger"
echo -e "${GREEN}" Press [N] for no, or [B] to back out and abort.
read -p "Enter choice " choice
case $choice in
Y) rm -r /usr/local/nullentrydev/ ;;
y) rm -r /usr/local/nullentrydev/ ;;
N) echo -e "backing out" ;;
n) echo -e "backing out" ;;
b) echo -e "backing out" ;;
B) echo -e "backing out" ;;
*) echo -e "${RED}Error...${STD}" ${CLEAR} && sleep 2
esac
}

  #start_masternodes_Menu
  manager_Start_Masternodes(){
  clear
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo "            Start Masternode(s)"
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  if [ -d /home/${COINl} ]; then
  echo -e "L -  Legacy Masternode"
  fi
  if [ -d /home/${COINl}1 ]; then
  echo -e "1 -  Masternode One"
  fi
  if [ -d /home/${COINl}2 ]; then
  echo -e "2 -  Masternode Two"
  fi
  if [ -d /home/${COINl}3 ]; then
  echo -e "3 -  Masternode Three"
  fi
  if [ -d /home/${COINl}4 ]; then
  echo -e "4 -  Masternode Four"
  fi
  if [ -d /home/${COINl}5 ]; then
  echo -e "5 -  Masternode Five"
  fi
  if [ -d /home/${COINl}6 ]; then
  echo -e "6 -  Masternode Six"
  fi
  if [ -d /home/${COINl}7 ]; then
  echo -e "7 -  Masternode Seven"
  fi
  if [ -d /home/${COINl}8 ]; then
  echo -e "8 -  Masternode Eight"
  fi
  if [ -d /home/${COINl}9 ]; then
  echo -e "9 -  Masternode Nine"
  fi
  if [ -d /home/${COINl}10 ]; then
  echo -e "10 - Masternode Ten"
  fi
  if [ -d /home/${COINl}12 ]; then
  echo -e "12 -  Masternode Elven"
  fi
  if [ -d /home/${COINl}12 ]; then
  echo -e "12 -  Masternode Twelve"
  fi
  if [ -d /home/${COINl}0 ]; then
  echo -e "0 -  Masternode Zero"
  fi
  echo -e "A -  Start All ${COIN3} Masternodes"
  echo -e "B-   Back - Previous Menu"
  echo -e "X -  Exit"
  Function_Read_Start_Masternodes_Menu
  }
  #start - read Start Masternodes Menu
  Function_Read_Start_Masternodes_Menu(){
  local choice
  read -p "Enter choice " choice
  case $choice in
    l) nodeunit=
    Function_Start_Masternode ;;
    L) nodeunit=
    Function_Start_Masternode ;;
    1) nodeunit=1
    Function_Start_Masternode ;;
    2) nodeunit=2
    Function_Start_Masternode ;;
    3) nodeunit=3
    Function_Start_Masternode ;;
    03) nodeunit=3
    Function_Start_Masternode ;;
    4) nodeunit=4
    Function_Start_Masternode ;;
    5) nodeunit=5
    Function_Start_Masternode ;;
    6) nodeunit=6
    Function_Start_Masternode ;;
    7) nodeunit=7
    Function_Start_Masternode ;;
    8) nodeunit=8
    Function_Start_Masternode ;;
    9) nodeunit=9
    Function_Start_Masternode ;;
    10) nodeunit=10
    Function_Start_Masternode ;;
    11) nodeunit=11
    Function_Start_Masternode ;;
    12) nodeunit=12
    Function_Start_Masternode ;;
    a) echo -e "Launching all Mastersnodes!"
    Function_Start_All_Nodes ;;
    A) echo -e "Launching all Mastersnodes!"
    Function_Start_All_Nodes ;;
    b) echo -e "backing out" ;;
    B) echo -e "backing out" ;;
    x) exit 0;;
    X) exit 0;;
    *) echo -e "${RED}Error...${STD}" ${CLEAR} && sleep 2
  esac
  }

  #start function_menu_Reindex_Masternodes
  function_menu_Reindex_Masternodes(){
  clear
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo "            Re-Index Masternode(s)"
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  if [ -d /home/${COINl} ]; then
  echo -e "L -  Legacy Masternode"
  fi
  if [ -d /home/${COINl}1 ]; then
  echo -e "1 -  Masternode One"
  fi
  if [ -d /home/${COINl}2 ]; then
  echo -e "2 -  Masternode Two"
  fi
  if [ -d /home/${COINl}3 ]; then
  echo -e "3 -  Masternode Three"
  fi
  if [ -d /home/${COINl}4 ]; then
  echo -e "4 -  Masternode Four"
  fi
  if [ -d /home/${COINl}5 ]; then
  echo -e "5 -  Masternode Five"
  fi
  if [ -d /home/${COINl}6 ]; then
  echo -e "6 -  Masternode Six"
  fi
  if [ -d /home/${COINl}7 ]; then
  echo -e "7 -  Masternode Seven"
  fi
  if [ -d /home/${COINl}8 ]; then
  echo -e "8 -  Masternode Eight"
  fi
  if [ -d /home/${COINl}9 ]; then
  echo -e "9 -  Masternode Nine"
  fi
  if [ -d /home/${COINl}10 ]; then
  echo -e "10 - Masternode Ten"
  fi
  if [ -d /home/${COINl}11 ]; then
  echo -e "11 - Masternode Eleven"
  fi
  if [ -d /home/${COINl}12 ]; then
  echo -e "12 - Masternode Twelve"
  fi
  if [ -d /home/${COINl}0 ]; then
  echo -e "0 - Masternode Zero"
  fi
  echo -e "B-   Back - Previous Menu"
  echo -e "X -  Exit"
  function_Read_Reindex_Masternodes
  }

  #start - read Start Masternodes Menu
  function_Read_Reindex_Masternodes(){
  local choice
  read -p "Enter choice " choice
  case $choice in
    l) nodeunit=
    function_reindex_masternode ;;
    L) nodeunit=
    function_reindex_masternode ;;
    1) nodeunit=1
    function_reindex_masternode ;;
    2) nodeunit=2
    function_reindex_masternode ;;
    3) nodeunit=3
    function_reindex_masternode ;;
    4) nodeunit=4
    function_reindex_masternode ;;
    5) nodeunit=5
    function_reindex_masternode ;;
    6) nodeunit=6
    function_reindex_masternode ;;
    7) nodeunit=7
    function_reindex_masternode ;;
    8) nodeunit=8
    function_reindex_masternode ;;
    9) nodeunit=9
    function_reindex_masternode ;;
    10) nodeunit=10
    function_reindex_masternode ;;
    11) nodeunit=11
    function_reindex_masternode ;;
    12) nodeunit=12
    function_reindex_masternode ;;
    0) nodeunit=0
    function_reindex_masternode ;;
    a) echo -e "Launching all Masters!"
    Function_Start_All_Nodes ;;
    A) echo -e "Launching all Masters!"
    Function_Start_All_Nodes ;;
    b) echo -e "backing out" ;;
    B) echo -e "backing out" ;;
    x) exit 0;;
    X) exit 0;;
    *) echo -e "${RED}Error...${STD}" ${CLEAR} && sleep 2
  esac
  }

  #End read Start Masternodes Menu
  function_reindex_masternode(){
  if [ -d /home/${COINl}${nodeunit} ]; then
  Function_Stop_Masternode
  echo -e ${GREEN}"Attempting Re-Indexing of Masternode ${nodeunit}" ${CLEAR}
  echo -e "Please wait" ${YELLOW}
  ${COINDAEMON} -datadir=${COINHOME}${nodeunit}/${COINCORE} -reindex
  sleep 15
  echo -e ${CLEAR}
  fi
  }

  ## Start ALL MN function
  Function_Start_All_Nodes(){
  local Count
  Count=0
  nodeunit=
  Function_Start_Masternode
  nodeunit=0
  until [[ $nodeunit = 13 ]]; do
  Function_Start_Masternode
  nodeunit=$[$nodeunit+1]
  done
  }

  #start Edit Masternode Status Menu
  Edit_MN_Status(){
  clear
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo "      Edit Masternode Configuration"
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  if [ -d /home/${COINl} ]; then
  echo -e "L - Legacy Masternode One Status"
  fi
  if [ -d /home/${COINl}1 ]; then
  echo -e "1 - Masternode One"
  fi
  if [ -d /home/${COINl}2 ]; then
  echo -e "2 - Masternode Two"
  fi
  if [ -d /home/${COINl}3 ]; then
  echo -e "3 - Masternode Three"
  fi
  if [ -d /home/${COINl}4 ]; then
  echo -e "4 - Masternode Four"
  fi
  if [ -d /home/${COINl}5 ]; then
  echo -e "5 - Masternode Five"
  fi
  if [ -d /home/${COINl}6 ]; then
  echo -e "6 - Masternode Six"
  fi
  if [ -d /home/${COINl}7 ]; then
  echo -e "7 - Masternode Seven"
  fi
  if [ -d /home/${COINl}8 ]; then
  echo -e "8 - Masternode Eight"
  fi
  if [ -d /home/${COINl}9 ]; then
  echo -e "9 - Masternode Nine"
  fi
  if [ -d /home/${COINl}10 ]; then
  echo -e "10 - Masternode Ten"
  fi
  if [ -d /home/${COINl}11 ]; then
  echo -e "11 - Masternode Eleven"
  fi
  if [ -d /home/${COINl}12 ]; then
  echo -e "12 - Masternode Twelve"
  fi
  if [ -d /home/${COINl}0 ]; then
  echo -e "0 - Masternode Zero"
  fi
  echo -e "B - Back out of Menu"
  echo -e "X - Exit"
  Function_Edit_Masternode_Config
  }

  Function_View_Masternode_Config_Menu(){
  clear
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo "      View Masternode Configuration"
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  if [ -d /home/${COINl} ]; then
  echo -e "L - Legacy Masternode One Status"
  fi
  if [ -d /home/${COINl}1 ]; then
  echo -e "1 - Masternode One"
  fi
  if [ -d /home/${COINl}2 ]; then
  echo -e "2 - Masternode Two"
  fi
  if [ -d /home/${COINl}3 ]; then
  echo -e "3 - Masternode Three"
  fi
  if [ -d /home/${COINl}4 ]; then
  echo -e "4 - Masternode Four"
  fi
  if [ -d /home/${COINl}5 ]; then
  echo -e "5 - Masternode Five"
  fi
  if [ -d /home/${COINl}6 ]; then
  echo -e "6 - Masternode Six"
  fi
  if [ -d /home/${COINl}7 ]; then
  echo -e "7 - Masternode Seven"
  fi
  if [ -d /home/${COINl}8 ]; then
  echo -e "8 - Masternode Eight"
  fi
  if [ -d /home/${COINl}9 ]; then
  echo -e "9 - Masternode Nine"
  fi
  if [ -d /home/${COINl}10 ]; then
  echo -e "10 - Masternode Ten"
  fi
  if [ -d /home/${COINl}10 ]; then
  echo -e "11 - Masternode Eleven"
  fi
  if [ -d /home/${COINl}10 ]; then
  echo -e "12 - Masternode Twelve"
  fi
  if [ -d /home/${COINl}0 ]; then
  echo -e "0 - Masternode Zero"
  fi
  echo -e "B - Back out of Menu"
  echo -e "X - Exit"
  Function_Read_Masternode_Config_Menu
  }

Function_Read_Masternode_Config_Menu(){
local choice
read -p "Enter choice : " choice
case $choice in
  l) nodeunit=
  Function_ViewCat_masternode ;;
  L) nodeunit=
  Function_ViewCat_masternode ;;
  1) nodeunit=1
  Function_ViewCat_masternode ;;
  2) nodeunit=2
  Function_ViewCat_masternode ;;
  3) nodeunit=3
  Function_ViewCat_masternode ;;
  4) nodeunit=4
  Function_ViewCat_masternode ;;
  5) nodeunit=5
  Function_ViewCat_masternode ;;
  6) nodeunit=6
  Function_ViewCat_masternode ;;
  7) nodeunit=7
  Function_ViewCat_masternode ;;
  8) nodeunit=8
  Function_ViewCat_masternode ;;
  9) nodeunit=9
  Function_ViewCat_masternode ;;
  10) nodeunit=10
  Function_ViewCat_masternode ;;
  11) nodeunit=11
  Function_ViewCat_masternode ;;
  12) nodeunit=12
  Function_ViewCat_masternode ;;
  0) nodeunit=0
  Function_ViewCat_masternode ;;
  b) echo -e "backing out" ;;
  B) echo -e "backing out" ;;
  x) exit 0;;
  X) exit 0;;
  *) echo -e "${RED}Error...${STD}" ${CLEAR} && sleep 2
esac
}

  #Function_Stop_Masternodes_Menu
  manager_stop_Masternodes(){
  clear
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo "          Stop Masternode(s)"
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  if [ -d /home/${COINl} ]; then
  echo -e "L - Legacy Masternode One Status"
  fi
  if [ -d /home/${COINl}1 ]; then
  echo -e "1 - Masternode One"
  fi
  if [ -d /home/${COINl}2 ]; then
  echo -e "2 - Masternode Two"
  fi
  if [ -d /home/${COINl}3 ]; then
  echo -e "3 - Masternode Three"
  fi
  if [ -d /home/${COINl}4 ]; then
  echo -e "4 - Masternode Four"
  fi
  if [ -d /home/${COINl}5 ]; then
  echo -e "5 - Masternode Five"
  fi
  if [ -d /home/${COINl}6 ]; then
  echo -e "6 - Masternode Six"
  fi
  if [ -d /home/${COINl}7 ]; then
  echo -e "7 - Masternode Seven"
  fi
  if [ -d /home/${COINl}8 ]; then
  echo -e "8 - Masternode Eight"
  fi
  if [ -d /home/${COINl}9 ]; then
  echo -e "9 - Masternode Nine"
  fi
  if [ -d /home/${COINl}10 ]; then
  echo -e "10 - Masternode Ten"
  fi
  if [ -d /home/${COINl}11 ]; then
  echo -e "11 - Masternode Eleven"
  fi
  if [ -d /home/${COINl}12 ]; then
  echo -e "12 - Masternode Twelve"
  fi
  if [ -d /home/${COINl}0 ]; then
  echo -e "0 - Masternode Zero"
  fi
  echo -e "A - stop All ${COIN3} Masternodes"
  echo -e "B - Back out of Menu"
  echo -e "X - Exit"
  read_stop_Masternodes
  }

  #read stop Masternodes Menu
  read_stop_Masternodes(){
  local choice
  read -p "Enter choice " choice
  case $choice in
    l) nodeunit=
    Function_Stop_Masternode ;;
    L) nodeunit=
    Function_Stop_Masternode ;;
    1) nodeunit=1
    Function_Stop_Masternode ;;
    2) nodeunit=2
    Function_Stop_Masternode ;;
    3) nodeunit=3
    Function_Stop_Masternode ;;
    4) nodeunit=4
    Function_Stop_Masternode ;;
    5) nodeunit=5
    Function_Stop_Masternode ;;
    6) nodeunit=6
    Function_Stop_Masternode ;;
    7) nodeunit=7
    Function_Stop_Masternode ;;
    8) nodeunit=8
    Function_Stop_Masternode ;;
    9) nodeunit=9
    Function_Stop_Masternode ;;
    10) nodeunit=10
    Function_Stop_Masternode ;;
    11) nodeunit=11
    Function_Stop_Masternode ;;
    12) nodeunit=12
    Function_Stop_Masternode ;;
    0) nodeunit=0
    Function_Stop_Masternode ;;
    a) echo -e "Stopping all Mastersnodes!"
    stop_All_Nodes ;;
    B) echo -e "Stopping all Mastersnodes!"
    stop_All_Nodes ;;
    b) echo -e "backing out" ;;
    B) echo -e "backing out" ;;
    x) exit 0;;
    X) exit 0;;
    *) echo -e "${RED}Error...${STD}" ${CLEAR} && sleep 2
  esac
  }

  ## stop ALL MN function
  stop_All_Nodes(){
  local Count
  Count=0
  nodeunit=
  Function_Stop_Masternode
  nodeunit=0
  until [[ $nodeunit = 10 ]]; do
  Function_Stop_Masternode
  nodeunit=$[$nodeunit+1]
  done
  pause
  }

  #Function set for Edit MN Config Menu
  edit_menu_choice(){
  if [ -d /home/${COINl}${nodeunit} ]; then
    clear
    echo -e "Stopping Masternode to Prevent Problems, please wait"
    Function_Stop_Masternode
    edit_masternode
    Function_Start_Masternode
  fi
  }

  Function_Edit_Masternode_Config(){
  local choice
  read -p "Enter choice : " choice
  case $choice in
    l) nodeunit=
    edit_menu_choice ;;
    L) nodeunit=
    edit_menu_choice ;;
    1) nodeunit=1
    edit_menu_choice ;;
    2) nodeunit=2
    edit_menu_choice ;;
    3) nodeunit=3
    edit_menu_choice ;;
    4) nodeunit=4
    edit_menu_choice ;;
    5) nodeunit=5
    edit_menu_choice ;;
    6) nodeunit=6
    edit_menu_choice ;;
    7) nodeunit=7
    edit_menu_choice ;;
    8) nodeunit=8
    edit_menu_choice ;;
    9) nodeunit=9
    edit_menu_choice ;;
    10) nodeunit=10
    edit_menu_choice ;;
    12) nodeunit=12
    edit_menu_choice ;;
    11) nodeunit=11
    edit_menu_choice ;;
    0) nodeunit=0
    edit_menu_choice ;;
    b) echo -e "backing out" ;;
    B) echo -e "backing out" ;;
    x) exit 0;;
    X) exit 0;;
    *) echo -e "${RED}Error...${STD}" ${CLEAR} && sleep 2
  esac
  }

  display_MN_Status(){
  clear
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo "      Displaying Masternode Status"
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  if [ -d /home/${COINl} ]; then
  echo -e "L - Legacy Masternode"
  fi
  if [ -d /home/${COINl}1 ]; then
  echo -e "1 - Masternode One"
  fi
  if [ -d /home/${COINl}2 ]; then
  echo -e "2 - Masternode Two"
  fi
  if [ -d /home/${COINl}3 ]; then
  echo -e "3 - Masternode Three"
  fi
  if [ -d /home/${COINl}4 ]; then
  echo -e "4 - Masternode Four"
  fi
  if [ -d /home/${COINl}5 ]; then
  echo -e "5 - Masternode Five"
  fi
  if [ -d /home/${COINl}6 ]; then
  echo -e "6 - Masternode Six"
  fi
  if [ -d /home/${COINl}7 ]; then
  echo -e "7 - Masternode Seven"
  fi
  if [ -d /home/${COINl}8 ]; then
  echo -e "8 - Masternode Eight"
  fi
  if [ -d /home/${COINl}9 ]; then
  echo -e "9 - Masternode Nine"
  fi
  if [ -d /home/${COINl}10 ]; then
  echo -e "10 - Masternode Ten"
  fi
  if [ -d /home/${COINl}11 ]; then
  echo -e "11 - Masternode Ten"
  fi
  if [ -d /home/${COINl}12 ]; then
  echo -e "12 - Masternode Ten"
  fi
  if [ -d /home/${COINl}0 ]; then
  echo -e "10 - Masternode Zero"
  fi
  echo -e "B - Back out of Menu"
  echo -e "X - Exit"
  read_display_MN_Status
  }

  display_MN_choice(){
  clear
  disp_masternode_Status
  disp_masternode_Chain
  display_MN_Status
  }

  read_display_MN_Status(){
  local choice
  read -p "Enter choice : " choice
  case $choice in
    l) nodeunit=
    display_MN_choice ;;
    L) nodeunit=
    display_MN_choice ;;
    1) nodeunit=1
    display_MN_choice ;;
    2) nodeunit=2
    display_MN_choice ;;
    3) nodeunit=3
    display_MN_choice ;;
    4) nodeunit=4
    display_MN_choice ;;
    5) nodeunit=5
    display_MN_choice ;;
    6) nodeunit=6
    display_MN_choice ;;
    7) nodeunit=7
    display_MN_choice ;;
    8) nodeunit=8
    display_MN_choice ;;
    9) nodeunit=9
    display_MN_choice ;;
    10) nodeunit=0
    display_MN_choice ;;
    b) echo -e "backing out" ;;
    B) echo -e "backing out" ;;
    x) exit 0;;
    X) exit 0;;
    *) echo -e "${RED}Error...${STD}" ${CLEAR} && sleep 2
  esac

  }
  disp_masternode_Status(){
  echo -e ${GREEN}"Reporting Masternode Status" ${YELLOW}
  ${COINDAEMONCLI} -datadir=${COINHOME}${nodeunit}/${COINCORE} masternode status
  echo -e ${CLEAR}
  }

  disp_masternode_Chain(){
  echo -e ${GREEN}"Reporting current Block on Chain" ${YELLOW}
  ${COINDAEMONCLI} -datadir=${COINHOME}${nodeunit}/${COINCORE} getblockcount
  echo -e ${CLEAR}
  pause
  }

  read_Find_MN_Status(){
  local choice
  read -p "Enter choice : " choice
  case $choice in
    l) nodeunit=
    Find_All_Masternodes ;;
    L) nodeunit=
    Find_All_Masternodes ;;
    1) nodeunit=1
    Find_All_Masternodes ;;
    2) nodeunit=2
    Find_All_Masternodes ;;
    3) nodeunit=3
    Find_All_Masternodes ;;
    4) nodeunit=4
    Find_All_Masternodes ;;
    5) nodeunit=5
    Find_All_Masternodes ;;
    6) nodeunit=6
    Find_All_Masternodes ;;
    7) nodeunit=7
    Find_All_Masternodes ;;
    8) nodeunit=8
    Find_All_Masternodes ;;
    9) nodeunit=9
    Find_All_Masternodes ;;
    10) nodeunit=10
    Find_All_Masternodes ;;
    11) nodeunit=11
    Find_All_Masternodes ;;
    12) nodeunit=12
    Find_All_Masternodes ;;
    0) nodeunit=0
    Find_All_Masternodes ;;
    b) echo -e "backing out" ;;
    B) echo -e "backing out" ;;
    x) exit 0;;
    X) exit 0;;
    *) echo -e "${RED}Error...${STD}" ${CLEAR} && sleep 2
  esac
  }

  Find_All_Masternodes(){
  local Count
  Count=0
  nodeunit=
  Function_Find_Masternodes
  nodeunit=0
  until [[ $nodeunit = 13 ]]; do
  Function_Find_Masternodes
  nodeunit=$[$nodeunit+1]
  done
  pause
  }

  # Find Masternode Test Function
  Function_Find_Masternodes(){
  local choice
  if [ -d /home/${COINl}${nodeunit} ]; then
    if [ -z ${nodeunit} ]; then
    echo -e ${GREEN}"Found XGS-Oldnode Installation Found - /home/${COINl}" ${CLEAR}
  else
    echo -e ${GREEN}"Found XGS-${nodeunit} Installation Found - /home/${COINl}${nodeunit}" ${CLEAR}
  fi
  ${COINDAEMONCLI} -datadir=${COINHOME}${nodeunit}/${COINCORE} masternode status &> ${DPATH}XGSMN${nodeunit}.tmp
    if grep -q "Hot node, waiting for remote activation" ${DPATH}XGSMN${nodeunit}.tmp; then
      echo -e ${YELLOW} "Masternode Ready, waiting for activation from Wallet" ${CLEAR}
    elif grep -q "Loading block index..." ${DPATH}XGSMN${nodeunit}.tmp; then
    echo -e ${YELLOW} "Masternode is still loading block Index, please wait." ${CLEAR}
    elif grep -q "Masternode successfully started" ${DPATH}XGSMN${nodeunit}.tmp; then
      echo -e ${GREEN} "Masternode Successfully Started" ${CLEAR}
    elif grep -q "Masternode not found in the list of available masternodes. Current status: Node just started, not yet activated" ${DPATH}XGSMN${nodeunit}.tmp; then
      echo -e ${YELLOW} "Masternode is loading blocks, Please Wait " ${CLEAR}
    elif grep -q "error: couldn't connect to server" ${DPATH}XGSMN${nodeunit}.tmp; then
      echo -e ${RED} "Masternode not running, Please Start"
      echo
      echo -e ${GREEN} "Would you like to attempt to start the Masternode? (Y/N) "
      read -p "Enter choice : " choice
      case $choice in
        y) Function_Start_Masternode ;;
        Y) Function_Start_Masternode ;;
        n) echo -e "backing out" ;;
        N) echo -e "backing out" ;;
        *) echo -e "${RED}Error...${STD}" ${CLEAR} && sleep 2
      esac
    fi
      ${COINDAEMONCLI} -datadir=${COINHOME}${nodeunit}/${COINCORE} masternode status &> ${DPATH}${nodeunit}.tmp
      DISPIP=$(sed -n '4p' < /usr/local/nullentrydev/${nodeunit}.tmp | cut -d'"' -f4 | cut -d':' -f1)
        if [[ "$DISPIP" =~ (([01]{,1}[0-9]{1,2}|2[0-4][0-9]|25[0-5])\.([01]{,1}[0-9]{1,2}|2[0-4][0-9]|25[0-5])\.([01]{,1}[0-9]{1,2}|2[0-4][0-9]|25[0-5])\.([01]{,1}[0-9]{1,2}|2[0-4][0-9]|25[0-5]))$ ]]; then
          echo -e "Running on IPv4 :${YELLOW} ${DISPIP}" ${CLEAR}
        else
        DISPIP=$(sed -n '4p' < /usr/local/nullentrydev/${nodeunit}.tmp | cut -d'"' -f4 | cut -d':' -f1-8)
          if [ ! -z "$DISPIP"]; then
            echo -e "Running on IPv6 : ${YELLOW} ${DISPIP}" ${CLEAR}
          fi
        fi
        rm -r /usr/local/nullentrydev/${nodeunit}.tmp
  DEVOld="1"
  DEV=$DEV+1
  fi
  echo
  }

  #start Function_AptGet_Update
  Function_AptGet_Update() {
    echo -e ${RED}"Updating Apps"${CLEAR}
    sudo apt-get -y update
    sudo apt-get -y upgrade
  }

  # Operating Systems Check
  function_first_run(){
        if [[ $(lsb_release -d) != *16.04* ]]; then
          echo -e ${RED}"The operating system is not Ubuntu 16.04. You must be running on ubuntu 16.04."${CLEAR}
          exit 1
        fi
        if [ ! -d /usr/local/nullentrydev/ ]; then
          echo "Making /usr/local/nullentrydev "
          sudo mkdir /usr/local/nullentrydev
          else
          echo "Found /usr/local/nullentrydev "
        fi
        if [ ! -f /usr/local/nullentrydev/${COIN3l}.log ]; then
          echo "Making /usr/local/nullentrydev/${COIN3l}.log"
          sudo touch /usr/local/nullentrydev/${COIN3l}.log
          else
            echo "Found /usr/local/nullentrydev/${COIN3l}.log"
        fi
        if [ ! -f /usr/local/nullentrydev/mnodes.log ]; then
          echo "Making /usr/local/nullentrydev/mnodes.log"
          sudo touch /usr/local/nullentrydev/mnodes.log
          else
          echo "Found /usr/local/nullentrydev/mnodes.log"
        fi
        function_first_nodecheck
      }
  function_dependencies(){
  if [ -f /usr/local/nullentrydev/mnodes.log ] && grep -Fxq "dependenciesInstalled: true" /usr/local/nullentrydev/mnodes.log
      then
  echo
  echo -e ${RED}"Skipping... Dependencies & Software Libraries - Previously installed"${CLEAR}
  echo
      else
  echo ${RED}"Installing Dependencies & Software Libraries"${CLEAR}
  sudo apt-get -y install software-properties-common
  sudo apt-get -y install build-essential
  sudo apt-get -y install libtool autotools-dev autoconf automake
  sudo apt-get -y install libssl-dev
  sudo apt-get -y install libevent-dev
  sudo apt-get -y install libboost-all-dev
  sudo apt-get -y install pkg-config
  sudo add-apt-repository -yu ppa:bitcoin/bitcoin
  sudo apt-get update
  sudo apt-get -y install libdb4.8-dev
  sudo apt-get -y install libdb4.8++-dev
  echo -e ${YELLOW} "Here be dragons"${CLEAR}
  sudo apt-get -y install libminiupnpc-dev libzmq3-dev libevent-pthreads-2.0-5
  sudo apt-get -y install libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev
  sudo apt-get -y install libqrencode-dev bsdmainutils unzip
    # Recording Dependencies & Software Libraries insatllation complete
    if [[ $NULLREC = "y" ]] ; then
      sudo echo "dependenciesInstalled: true" >> /usr/local/nullentrydev/mnodes.log
    fi
    fi
  echo "${COIN3}firstrun_complete: true" >> /usr/local/nullentrydev/mnodes.log
  }

  #Firstnode Installation Check
  function_first_nodecheck(){
        if [ -d /home/${COINl} ]; then
          echo -e ${GREEN}"Found ${COINl}-Oldnode Installation Found - /home/${COINl}" ${CLEAR}
        else
          if [ -d /home/${COINl}1 ]; then
          echo -e ${GREEN}"Found ${COINl} Masternode Installation Found - /home/${COINl}" ${CLEAR}
        else
        #install FirstMasternode - Start!
        nodeunit=1
        clear
        echo
        echo -e "Testing Version - Not for public release."
        echo
        echo -e "${RED}Let's set up your first ${COINl} masternode before we continue..."
        echo -e "${GREEN}This is going to take a few minutes, and when done will display"
        echo -e "${GREEN}information you need for your masternode.conf on your local wallet"
        echo
        echo -e ${GREEN}"How Many Masternode Would you like to Install? [1 - 12]"${CLEAR}
        echo -e ${YELLOW}
        read INSTALLAMOUNT
        echo -e ${CLEAR}
        echo -e ${RED}"            ...Please Wait" ${CLEAR}
        sleep 5
        Function_First_Install
        fi
      fi
      }

  #start function_swap_space
  function_swap_space(){
  if grep -Fxq "swapInstalled: true" /usr/local/nullentrydev/mnodes.log
  then
  echo -e ${RED}"Skipping... Swap Area already made"${CLEAR}
  else
  cd /var
  sudo touch swap.img
  sudo chmod 600 swap.img
  sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=4096
  sudo mkswap /var/swap.img
  sudo swapon /var/swap.img
  echo "swapInstalled: true" >> /usr/local/nullentrydev/mnodes.log
  fi
  }

  download_coinfiles(){
  cd ~
  if [ ! -d /root/${COIN3l} ]; then
  sudo mkdir /root/${COIN3l}
  fi
  cd /root/${COIN3l}
  #Download Wallet Files
  echo "Downloading latest ${COIN} binaries"
  wget ${DOWNLOADCOINFILES}
  ${DECOMPRESS} ${COINFILES}
  sleep 3
  sudo mv /root/${COIN3l}/${COINDAEMON} /root/${COIN3l}/${COINDAEMONCLI} /usr/local/bin
  sudo chmod 755 -R  /usr/local/bin/${COINl}*
  }

  ##Make Node configuration file
  Function_Build_Node_Directories(){
  echo -e "${GREEN}Configuring ${COIN} Masternode #${nodeunit} ${CLEAR}"
  if [ ! -d /home/${COINl}${nodeunit} ]; then
      sudo mkdir /home/${COINl}${nodeunit}
    elif [ ! -d /home/${COINl}${nodeunit}/.${COINl} ]; then
      sudo mkdir /home/${COINl}${nodeunit}/.${COINl}
    fi
}
  Function_Build_Node_Configuration(){
  Function_Build_Node_Directories
  if [ ! -f /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG} ]; then
  sudo touch /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "rpcuser=u3er"`shuf -i 100000-9999999 -n 1` >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "rpcpassword=pa55"`shuf -i 100000-9999999 -n 1` >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "rpcallowip=127.0.0.1" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  Function_IP_Table_Check
  Function_Masternode_Key_Check
  echo "server=1" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "daemon=1" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "maxconnections=256" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "masternode=1" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  RPCPORT=$(($COINRPCPORT+$nodeunit-1))
  echo "rpcport=${RPCPORT}" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  if [[ $nodeunit -eq 1 ]] ; then
    echo "listen=1" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    echo "datacarrier=1" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  fi
  if [[ ! $nodeunit -eq 1 ]] ; then
    echo "listen=0" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  fi
  if [[ $nodeunit -eq 1 ]] ; then
    echo "externalip=${MNIP1}:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 2 ]] ; then
      echo "externalip=[${MNIP2}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 3 ]] ; then
      echo "externalip=[${MNIP3}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 4 ]] ; then
      echo "externalip=[${MNIP4}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 5 ]] ; then
      echo "externalip=[${MNIP5}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 6 ]] ; then
      echo "externalip=[${MNIP6}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 7 ]] ; then
      echo "externalip=[${MNIP7}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 8 ]] ; then
      echo "externalip=[${MNIP8}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 9 ]] ; then
      echo "externalip=[${MNIP9}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 10 ]] ; then
      echo "externalip=[${MNIP10}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 11 ]] ; then
      echo "externalip=[${MNIP11}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 12 ]] ; then
      echo "externalip=[${MNIP12}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  fi
  if [[ $nodeunit -eq 1 ]] ; then
  echo "masternodeprivkey=$PRIVK1" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 2 ]] ; then
  echo "masternodeprivkey=$PRIVK2" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 3 ]] ; then
  echo "masternodeprivkey=$PRIVK3" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 4 ]] ; then
  echo "masternodeprivkey=$PRIVK4" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 5 ]] ; then
  echo "masternodeprivkey=$PRIVK5" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 6 ]] ; then
  echo "masternodeprivkey=$PRIVK6" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 7 ]] ; then
  echo "masternodeprivkey=$PRIVK7" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 8 ]] ; then
  echo "masternodeprivkey=$PRIVK8" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 9 ]] ; then
  echo "masternodeprivkey=$PRIVK9" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 10 ]] ; then
  echo "masternodeprivkey=$PRIVK10" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 11 ]] ; then
  echo "masternodeprivkey=$PRIVK11" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 12 ]] ; then
  echo "masternodeprivkey=$PRIVK12" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  fi
    if [[ $nodeunit -eq 1 ]] ; then
  echo "addnode=$ADDNODE0" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE1" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE2" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE3" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE4" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE5" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE6" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE7" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE8" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE9" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE10" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE11" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE12" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  else
  echo "addnode=${MNIP1}" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  fi
else
  echo -e "Skipping -/home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}- Found!"
fi
  }

Function_Glances(){
  if grep -Fxq "glancesInstalled: true" /usr/local/nullentrydev/mnodes.log
    then
      clear
      echo
      echo -e ${RED}"Hold [Control Key] and press [C] to exit Glances!"${CLEAR}
      echo -e ${GREEN}"Press [Enter Key] when ready to enter Glances."${CLEAR}
      pause
      glances
    else
      echo -e ${YELLOW} "Installing System Utility Glances" ${CLEAR}
      apt-get -y install glances
      echo "glancesInstalled: true" >> /usr/local/nullentrydev/mnodes.log
      Function_Glances
  fi
}

  ## Start Launch First node
  launch_first_node(){
  echo -e ${BOLD}"Launching First ${COIN3} Node"${CLEAR}
  ${COINDAEMON} -datadir=/home/${COINl}1/.${COINl} -daemon
  sleep 1
    if [ -f /usr/local/nullentrydev/${COIN3l}.log ]; then
      sudo rm -rf /usr/local/nullentrydev/${COIN3l}.log
      sudo touch /usr/local/nullentrydev/${COIN3l}.log
    fi
    echo "masterNode1 : true" >> /usr/local/nullentrydev/${COIN3l}.log
    echo "walletVersion1 : $COINVERSION" >> /usr/local/nullentrydev/${COIN3l}.log
    echo "scriptVersion1 : $SCRIPTVERSION" >> /usr/local/nullentrydev/${COIN3l}.log
  }

  ##Start Waiting for Launch of First Nodes
  wait_first_node_launch(){
  echo
  echo -e "${RED}This process can take a while!${CLEAR}"
  echo -e "${YELLOW}Waiting on First Masternode Block Chain to Synchronize${CLEAR}"
  echo -e "${YELLOW}Once complete, it will stop and copy the block chain to${CLEAR}"
  echo -e "${YELLOW}the other masternodes.  This will prevent all masternodes${CLEAR}"
  echo -e "${YELLOW}from downloading the block chain individually; taking up${CLEAR}"
  echo -e "${YELLOW}more time and resources.  Current Block count will be displayed below.${CLEAR}"
  ${COINDAEMONCLI} -datadir=/home/${COINl}${nodeunit}/${COINCORE} getblockcount
  sleep 5
  until ${COINDAEMONCLI} -datadir=/home/${COINl}${nodeunit}/${COINCORE} mnsync status | grep -m 1 'IsBlockchainSynced" : true'; do
    ${COINDAEMONCLI} -datadir=/home/${COINl}${nodeunit}/${COINCORE} getblockcount
    sleep 5
  done
  }

  ##Start of replicate nodes
  Function_Replicate_Node(){
  if [ ! -f /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG} ]; then
  echo -e "${GREEN}Haulting and Replicating First ${COIN} Node${CLEAR}"
  echo
  sleep 2
  Function_Build_Node_Directories
  cd /
  sleep 2
  sudo cp -r /home/${COINl}1/.${COINl}/* /home/${COINl}${nodeunit}/.${COINl}/
  sudo rm /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    if [ -a /home/${COINl}${nodeunit}/${COINCONFIG} ]; then
      sudo cp -r /home/${COINl}${nodeunit}/${COINCONFIG} /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    fi
  else
  echo -e "Skipping -/home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG} Found!"
  fi
}
  ### Start - Masternode function_Masternode_upgrade
  function_masternode_upgrade(){
    clear
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo "  How Many Masternode Do you want to Run?"
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo -e "1  - One Masternode"
    echo -e "2  - Masternode Two"
    echo -e "3  - Masternode Three"
    echo -e "4  - Masternode Four"
    echo -e "5  - Masternode Five"
    echo -e "6  - Masternode Six"
    echo -e "7  - Masternode Seven"
    echo -e "8  - Masternode Eight"
    echo -e "9  - Masternode Nine"
    echo -e "10 - Masternode Ten"
    echo -e "11 - Masternode Eleven"
    echo -e "12 - Masternode Twelve"
    echo -e "B  - Back out of Menu"
    echo -e "X  - Exit"
    Function_Read_Masternode_Upgrade
  }

  #start - read Start Masternodes Menu
  Function_Read_Masternode_Upgrade(){
    local choice
    read -p "Enter choice " choice
    case $choice in
      1) Function_Build_First_Node ;;
      2) INSTALLAMOUNT=2
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      3) INSTALLAMOUNT=3
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      4)INSTALLAMOUNT=4
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      5)INSTALLAMOUNT=5
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      6)INSTALLAMOUNT=6
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      7)INSTALLAMOUNT=7
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      8)INSTALLAMOUNT=8
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      9)INSTALLAMOUNT=9
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      10)INSTALLAMOUNT=10
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      11)INSTALLAMOUNT=11
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      12)INSTALLAMOUNT=12
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      b) echo -e "backing out" ;;
      B) echo -e "backing out" ;;
      x) exit 0;;
      X) exit 0;;
      *) echo -e "${RED}Error...${STD}" ${CLEAR} && sleep 2 && function_read_masternode_upgrade
    esac
  }

  function_Donations(){
  #attempt to move legacy masternode
    bash <(curl -Ls https://raw.githubusercontent.com/sburns1369/GenesisX_MN_Script/master/donations.sh)
    pause
  }

Function_IP_Table_Check(){
    if [ ! -f ${DPATH}ip.tbl ]; then
      Function_Build_IP_Table
      Function_Read_IP_Table
    else
      Function_Read_IP_Table
    fi
}

Function_Build_IP_Table(){
  if [[ customIP = "y" ]] ; then
  echo -e ${GREEN}"IP for Masternode 1"${CLEAR}
  read MNIP1
  echo -e ${GREEN}"IP for Masternode 2"${CLEAR}
  read MNIP2
  echo -e ${GREEN}"IP for Masternode 3"${CLEAR}
  read MNIP3
  echo -e ${GREEN}"IP for Masternode 4"${CLEAR}
  read MNIP4
  echo -e ${GREEN}"IP for Masternode 5"${CLEAR}
  read MNIP5
  echo -e ${GREEN}"IP for Masternode 6"${CLEAR}
  read MNIP6
  echo -e ${GREEN}"IP for Masternode 7"${CLEAR}
  read MNIP7
  echo -e ${GREEN}"IP for Masternode 8"${CLEAR}
  read MNIP8
  echo -e ${GREEN}"IP for Masternode 9"${CLEAR}
  read MNIP9
  echo -e ${GREEN}"IP for Masternode 10"${CLEAR}
  read MNIP10
  else
  regex='^([0-9a-fA-F]{0,4}:){1,7}[0-9a-fA-F]{0,4}$'
  FINDIP=$(hostname -I | cut -f2 -d' '| cut -f1-7 -d:)
  if [[ $FINDIP =~ $regex ]]; then
  IP=${FINDIP}
  else
  echo "IPv6 Address check is not expected, getting IPv6 Helper to recalculate"
  sudo apt-get -y install sipcalc
  FINDIP=$(hostname -I | cut -f3 -d' '| cut -f1-8 -d:)
  echo "Attempting to adjust results and re-calculate IPv6 Address"
  echo "This is normal for some VPS Providers, please wait."
  FINDIP=$(sipcalc ${FINDIP} | fgrep Expanded | cut -d ' ' -f3)
  if [[ $FINDIP =~ $regex ]]; then
  FINDIP=$(echo ${FINDIP} | cut -f1-7 -d:)
  echo "IPv6 Address check is good"
  IP=${FINDIP}
  else
  echo "IPv6 Addressing check has failed. Contact NullEntry Support"
  exit 1
  fi
  fi
  echo -e ${YELLOW} "Building IP Tables"${CLEAR}
  sudo touch ${DPATH}ip.tbl
  echo \#If editing IP Table list them below.  Starting from masternode 1 to 10 > ${DPATH}ip.tbl
  echo \#IPv4 and IPv6 are accepted.  Masternode needs to be rebuilt >> ${DPATH}ip.tbl
  echo \#unless IPs are entered in configuration directly.  >> ${DPATH}ip.tbl
  echo $(hostname -I | cut -f1 -d' ') >> ${DPATH}ip.tbl
  for i in {15362..15375}; do printf "${IP}:%.4x\n" $i >> ${DPATH}ip.tbl; done
  fi
}

  Function_Read_IP_Table(){
  cd ~
  MNIP1=$(sed -n '4p' < ${DPATH}ip.tbl)
  MNIP2=$(sed -n '5p' < ${DPATH}ip.tbl)
  MNIP3=$(sed -n '6p' < ${DPATH}ip.tbl)
  MNIP4=$(sed -n '7p' < ${DPATH}ip.tbl)
  MNIP5=$(sed -n '8p' < ${DPATH}ip.tbl)
  MNIP6=$(sed -n '9p' < ${DPATH}ip.tbl)
  MNIP7=$(sed -n '10p' < ${DPATH}ip.tbl)
  MNIP8=$(sed -n '11p' < ${DPATH}ip.tbl)
  MNIP9=$(sed -n '12p' < ${DPATH}ip.tbl)
  MNIP10=$(sed -n '13p' < ${DPATH}ip.tbl)
  MNIP11=$(sed -n '14p' < ${DPATH}ip.tbl)
  MNIP12=$(sed -n '15p' < ${DPATH}ip.tbl)
  }

  Function_Build_First_Node(){
  Function_AptGet_Update
  }

Function_Masternode_Key_Check(){
  if [ ! -f ${DPATH}${COIN3l}mnkey.tbl ]; then
    Function_Build_Masternode_Key_Table
    Function_Read_Masternode_Key_Table
  else
    Function_Read_Masternode_Key_Table
  fi
}

Function_Build_Masternode_Key_Table(){
    local count
    echo -e ${YELLOW} "Building Masternode Keys Table"${CLEAR}
    echo -e ${RED}"This Will take a moment"${CLEAR}
    nodeunit=1
    Function_Start_Masternode
    sleep 20
    until ${COINDAEMONCLI} -datadir=/home/${COINl}${nodeunit}/${COINCORE} mnsync status | grep -m 1 'IsBlockchainSynced" : true'; do
      ${COINDAEMONCLI} -datadir=/home/${COINl}${nodeunit}/${COINCORE} getblockcount
      sleep 30
    done
    sudo touch ${DPATH}${COIN3l}mnkey.tbl
    echo \#If editing IP Table list them below.  Starting from masternode 1 to 10 > ${DPATH}${COIN3l}mnkey.tbl
    echo \Masternode needs to be rebuilt in order for these to take effect >> ${DPATH}${COIN3l}mnkey.tbl
    echo \#unless keys are entered in configuration directly.  >> ${DPATH}${COIN3l}mnkey.tbl
    count=0
    until [[ $count = 13 ]]; do
    ${COINDAEMONCLI} -datadir=/home/${COINl}1/.${COINl} masternode genkey >> ${DPATH}${COIN3l}mnkey.tbl
    count=$[$count+1]
    done
    Function_Stop_Masternode
    }

Function_Read_Masternode_Key_Table(){
    cd ~
    PRIVK1=$(sed -n '4p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK2=$(sed -n '5p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK3=$(sed -n '6p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK4=$(sed -n '7p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK5=$(sed -n '8p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK6=$(sed -n '9p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK7=$(sed -n '10p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK8=$(sed -n '11p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK9=$(sed -n '12p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK10=$(sed -n '13p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK11=$(sed -n '14p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK12=$(sed -n '15p' < ${DPATH}${COIN3l}mnkey.tbl)
  }

  Function_User_Add_Check(){
  if id "${COINl}${nodeunit}" >/dev/null 2>&1; then
  echo "${COINl}${nodeunit}user exists"
  else
  sudo adduser --system --home /home/${COINl}${nodeunit} ${COINl}${nodeunit}
  fi
  }

  ## Start Bootstrap
  function_bootstrap(){
  cd ~
  if [ ! -d /root/${COIN3l} ]; then
  sudo mkdir /root/${COIN3l}
  fi
  cd /root/${COIN3l}
  echo "Attempting to get Bootstrap, please wait"
  #Test_Pause
  wget ${NEBootStrap}
  sleep 1
  if [ ! -d ${COINl}1/.${COINl} ]; then
  echo "Making /home/${COINl}1/.${COINl} "
  sudo mkdir /home/${COINl}1/.${COINl}
  else
  echo "Found /home/${COINl}1/.${COINl} "
  fi
  sudo apt-get -y install unrar
  unrar x rocketstrap.rar /home/${COINl}1/.${COINl}
  rm -rf /root/${COIN3l}
  }

  Function_Display_MasternodeConf(){
    echo -e "${GREEN} Retreiving inputs for the local wallet masternode.conf"
    echo -e "${YELLOW} Please Wait...."
      if [ -z "$MNIP1" ]; then
        Function_IP_Table_Check
      fi
      if [ -z "$PRIVK1" ]; then
        Function_Masternode_Key_Check
      fi
    echo -e "${RED}#Copy and paste the below lines in your Masternode.conf for the wallet on your computer"
    echo -e "#replace the [Insert Transaction ID] [Insert Transaction output 0 or 1]"
    echo -e "#The Alias listed ${COIN3l}01 etc, are just suggestions and can be replaced"
    echo -e "${YELLOW}#If you have a problem seeing this expand your window, or copy while scrolling"
    echo -e ${GREEN}
    if [ -f /home/${COINl}1/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}01 ${MNIP1}:$COINPORT $PRIVK1 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}2/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}02 [${MNIP2}]:$COINPORT $PRIVK2 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}3/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}03 [${MNIP3}]:$COINPORT $PRIVK3 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}4/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}04 [${MNIP4}]:$COINPORT $PRIVK4 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}5/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}05 [${MNIP5}]:$COINPORT $PRIVK5 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}6/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}06 [${MNIP6}]:$COINPORT $PRIVK6 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}7/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}07 [${MNIP7}]:$COINPORT $PRIVK7 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}8/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}08 [${MNIP8}]:$COINPORT $PRIVK8 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}9/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}09 [${MNIP9}]:$COINPORT $PRIVK9 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}10/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}10 [${MNIP10}]:$COINPORT $PRIVK10 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}11/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}11 [${MNIP11}]:$COINPORT $PRIVK11 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}12/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}12 [${MNIP12}]:$COINPORT $PRIVK12 [Transaction ID] [Transaction Output]"
    fi
    echo -e "${CLEAR}"
    pause
  }

  Function_Install_Secondaries(){
    INSTALLEDMN=1
    ${COINDAEMONCLI} -datadir=/home/${COINl}1/${COINCORE} stop
    sleep 15
    echo
      until [[ $INSTALLAMOUNT = $INSTALLEDMN ]]; do
      INSTALLEDMN=$[$INSTALLEDMN+1]
      nodeunit=$[$INSTALLEDMN]
      Function_User_Add_Check
      Function_Replicate_Node
      Function_Build_Node_Configuration
      done
      Function_Start_All_Nodes
    }

  #First node installation Core
  Function_First_Install(){
  function_swap_space
  Function_AptGet_Update
  function_dependencies
  Function_User_Add_Check
  download_coinfiles
  function_bootstrap
  nodeunit=1
  Function_Build_Node_Configuration
  launch_first_node
  Function_Rocket_Delay
  wait_first_node_launch
    if [[ ! $INSTALLAMOUNT -eq 1 ]] ; then
      Function_Install_Secondaries
    fi
  Function_Display_MasternodeConf
  }

  #Main Program Core
  clear
  Function_Display_Null_Logo
  Function_Display_Genesisx_Logo
  Function_Check_First_Run
  function_first_nodecheck
  while true
  do
  Function_Show_Main_Menu
  echo
  done
