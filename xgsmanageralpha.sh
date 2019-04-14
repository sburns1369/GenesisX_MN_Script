#!/bin/bash
declare -i NC XGS XGSC XGSOld XGSMN0 XGSMN1 XGSMN2 XGSMN3 XGSMN4 XGSMN5 XGSMN6 XGSMN7 XGSMN8
#Counter
NC=0
#Coin MN found 0 false 1 true
XGS=0
#Masternode Counter
XGSC=0
#Coinname Lowercase
COINl=genesisx
#Coin ticket symbol
COIN3=XGS
COINDAEMON=genesisxd
COINDAEMONCLI=genesisx-cli
COINCORE=.genesisx
COINCONFIG=genesisx.conf
COINHOME=/home/genesisx
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
#Null Entry logo
null_logo(){
echo
echo
echo -e " ${BLUE} "
echo "    ███╗   ██╗██╗  ██╗██╗    ██╗    ██████╗███╗   ██╗██████╗█████╗ ██╗   ██╗    ";
echo "    ████╗  ██║██║  ██║██║    ██║    ██╔═══╝████╗  ██║╚═██╔═╝██╔═██╗╚██╗ ██╔╝    ";
echo "    ██╔██╗ ██║██║  ██║██║    ██║    █████╗ ██╔██╗ ██║  ██║  █████╔╝ ╚████╔╝     ";
echo "    ██║╚██╗██║██║  ██║██║    ██║    ██╔══╝ ██║╚██╗██║  ██║  ██╔═██╗  ╚██╔╝      ";
echo "    ██║ ╚████║╚█████╔╝██████╗██████╗██████╗██║ ╚████║  ██║  ██║ ██║   ██║       ";
echo "    ╚═╝  ╚═══╝ ╚════╝ ╚═════╝╚═════╝╚═════╝╚═╝  ╚═══╝  ╚═╝  ╚═╝ ╚═╝   ╚═╝       ";
echo "                                                                                       ";
echo "███╗   ███╗ ████╗ █████╗██████╗██████╗██████╗ ███╗   ██╗ ████╗ █████╗ ██████╗";
echo "████╗ ████║██╔═██╗██╔══╝╚═██╔═╝██╔═══╝██╔══██╗████╗  ██║██╔═██╗██╔═██╗██╔═══╝";
echo "██╔████╔██║██████║█████╗  ██║  ████╗  ██████╔╝██╔██╗ ██║██║ ██║██║ ██║████╗  ";
echo "██║╚██╔╝██║██╔═██║╚══██║  ██║  ██╔═╝  ██╔══██╗██║╚██╗██║██║ ██║██║ ██║██╔═╝  ";
echo "██║ ╚═╝ ██║██║ ██║█████║  ██║  ██████╗██║  ██║██║ ╚████║╚████╔╝█████╔╝██████╗";
echo "╚═╝     ╚═╝╚═╝ ╚═╝╚════╝  ╚═╝  ╚═════╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═══╝ ╚════╝ ╚═════╝";
echo "                                                                                       ";
echo "         ███╗   ███╗ █████╗ ███╗   ██╗ █████╗  ██████╗ ███████╗██████╗              ";
echo "         ████╗ ████║██╔══██╗████╗  ██║██╔══██╗██╔════╝ ██╔════╝██╔══██╗             ";
echo "         ██╔████╔██║███████║██╔██╗ ██║███████║██║  ███╗█████╗  ██████╔╝             ";
echo "         ██║╚██╔╝██║██╔══██║██║╚██╗██║██╔══██║██║   ██║██╔══╝  ██╔══██╗             ";
echo "         ██║ ╚═╝ ██║██║  ██║██║ ╚████║██║  ██║╚██████╔╝███████╗██║  ██║             ";
echo "         ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝             ";
echo "                                                                                       ";
echo -e " ${CLEAR} ";
echo "                                                                                       ";
#ASCII art generated from patorjk.com
pause
}
#GenesisX logo
GenesisX_Logo(){
  clear
  echo "                                                                      ";
  echo "                                                                      ";
  echo "                                                                      ";
  echo -e ${YELLOW}"   ██████╗ ███████╗███╗   ██╗███████╗███████╗██╗███████╗ ${RED}   ██╗  ██╗ ";
  echo -e ${YELLOW}"  ██╔════╝ ██╔════╝████╗  ██║██╔════╝██╔════╝██║██╔════╝ ${RED}   ╚██╗██╔╝ ";
  echo -e ${YELLOW}"  ██║  ███╗█████╗  ██╔██╗ ██║█████╗  ███████╗██║███████╗ ${RED}    ╚███╔╝  ";
  echo -e ${YELLOW}"  ██║   ██║██╔══╝  ██║╚██╗██║██╔══╝  ╚════██║██║╚════██║ ${RED}    ██╔██╗  ";
  echo -e ${YELLOW}"  ╚██████╔╝███████╗██║ ╚████║███████╗███████║██║███████║ ${RED}   ██╔╝ ██╗ ";
  echo -e ${YELLOW}"   ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚══════╝╚══════╝╚═╝╚══════╝ ${RED}   ╚═╝  ╚═╝ ";
  echo -e "                                                                   ";
  echo -e "${GREEN}                                                           ";
  echo -e "                          SECURITY | PRIVACY                       ";
  echo -e "                      TRANSPARENCY | GOVERNANCE                    ";
  echo -e "                                                                   ";
  echo -e "                 On the Web --  https://www.genesisx.network/      ";
  echo -e "             XGS Offical Discord -- https://discord.gg/Vbh7CgG     ";
  echo -e "                                                                   ";
  echo
  echo -e "${BLUE}  This Script was made by request of a community member"
  echo -e "${BLUE}  NOT to be mistaken as part of the offical BGX Project"
  echo -e "${CLEAR}"
  echo
  echo
  echo
  pause
  }
BitCoinGenX_Logo(){
  clear
  echo
  echo
  echo -e "${GREEN}"
  echo -e " ██████╗ ██╗████████╗ ██████╗ ██████╗ ██╗███╗   ██╗ ";
  echo -e " ██╔══██╗██║╚══██╔══╝██╔════╝██╔═══██╗██║████╗  ██║ ";
  echo -e " ██████╔╝██║   ██║   ██║     ██║   ██║██║██╔██╗ ██║ ";
  echo -e " ██╔══██╗██║   ██║   ██║     ██║   ██║██║██║╚██╗██║ ";
  echo -e " ██████╔╝██║   ██║   ╚██████╗╚██████╔╝██║██║ ╚████║ ";
  echo -e " ╚═════╝ ╚═╝   ╚═╝    ╚═════╝ ╚═════╝ ╚═╝╚═╝  ╚═══╝ ";
  echo -e "   ${YELLOW}                                ██╗      ██╗              "
  echo -e "     ${RED}                              ╚██╗    ██╔╝              "
  echo -e "  ${YELLOW}     ██████╗ ███████╗███╗   ██╗   ╚██╗  ██╔╝    ";
  echo -e "  ${YELLOW}    ██╔════╝ ██╔════╝████╗  ██║${RED}    ╚██╗██╔╝    ";
  echo -e "  ${YELLOW}    ██║  ███╗█████╗  ██╔██╗ ██║     ╚███╔╝     ";
  echo -e "  ${YELLOW}    ██║   ██║██╔══╝  ██║╚██╗██║${RED}     ██╔██╗     ";
  echo -e "  ${YELLOW}    ╚██████╔╝███████╗██║ ╚████║    ██╔╝ ██╗    ";
  echo -e "  ${YELLOW}     ╚═════╝ ╚══════╝╚═╝  ╚═══╝${RED}   ██╔╝   ██╗    ";
  echo -e "  ${YELLOW}        * Green Protocol *       ██╔╝     ██╗    ";
  echo -e " ${RED}       * ZeroCoin Protocol *      ╚═╝      ╚═╝         "
  echo
  echo -e "${GREEN}        On the Web : https://btcgenx.net/ "
  echo -e "${GREEN}   Offical Discord : https://discord.gg/QQHgkuV "
  echo
  echo -e "${BLUE}  This Script was made by request of a community member"
  echo -e "${BLUE}  NOT to be mistaken as part of the offical BGX Project"
  echo -e "${CLEAR}"
  echo
  pause
}
#Main menu
show_mainMenu() {
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~"
	echo " M A I N - M E N U"
	echo "~~~~~~~~~~~~~~~~~~~~~"
  echo -e "1 - My Masternode(s) Status"
  echo -e "2 - Install or Add Masternodes (Not Implimented)"
  echo -e "3 - Masternode Manager"
  echo -e "5 - Maintenance - (Not Implimented)"
  echo -e "4 - Donate - (Not Implimented)"
  echo -e "X - Exit"
  read_MainMenuOptions
}
# root menu - read options
read_MainMenuOptions(){
	local choice
	read -p "Enter choice : " choice
	case $choice in
		1) find_Masternodes ;;
		2) function_new_masternode_install_menu ;;
    3) manager_XGSMasternodes;;
    4) find_Masternodes_test ;;
    x) exit 0;;
		*) echo -e "${RED}Error...${STD}" ${CLEAR} && sleep 2
	esac
}
#start Masternode
start_masternode(){
  if [ -d /home/${COINl}${nodeunit} ]; then
    echo -e ${GREEN}"Starting Masternode ${nodeunit}" ${CLEAR}
    echo -e "Please wait" ${YELLOW}
    ${COINDAEMON} -datadir=${COINHOME}${nodeunit}/${COINCORE} -daemon
    sleep 15
    echo -e ${CLEAR}
  else
    echo -e "Here be dragons"
  fi
}
#start Masternode
stop_masternode(){
  if [ -d /home/${COINl}${nodeunit} ]; then
    echo -e ${GREEN}"Stopping Masternode ${nodeunit}" ${YELLOW}
    ${COINDAEMONCLI} -datadir=${COINHOME}${nodeunit}/${COINCORE} stop
    sleep 15
    echo -e ${CLEAR}
  else
    echo -e "Here be dragons"
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
# manager_XGSMasternodes menu
manager_XGSMasternodes(){
  clear
  echo "~~~~~~~~~~~~~~~~~~~~~"
	echo " Displaying display_MN_Status"
	echo "~~~~~~~~~~~~~~~~~~~~~"
  echo -e "1 - Display Information"
  echo -e "2 - Edit Configuration"
  echo -e "3 - Start Masternode(s)"
  echo -e "4 - Stop Masternode(s)"
  echo -e "5 - Re-Index Masternode(s)"
	echo -e "X - Exit"
  read_manager_XGSMasternodes
}
# manager_XGSMasternodes read options
read_manager_XGSMasternodes(){
	local choice
	read -p "Enter choice " choice
	case $choice in
    1) display_MN_Status ;;
    2) Edit_MN_Status ;;
    3) manager_Start_Masternodes ;;
    4) manager_stop_Masternodes ;;
    5) function_menu_Reindex_Masternodes ;;
    x) exit 0;;
		*) echo -e "${RED}Error...${STD}" ${CLEAR} && sleep 2
	esac
}
## end MN Start Menu options

#Start - manager_maintenance menu
manager_maintenance(){
  clear
  echo "~~~~~~~~~~~~~~~~~~~~~"
	echo " Displaying Maintainance Options"
	echo "~~~~~~~~~~~~~~~~~~~~~"
  echo -e "1 - Update Wallet"
  echo -e "B - Back Out of Menu"
	echo -e "X - Exit Program"
  read_manager_maintenance
}
#Start - manager_maintenance read options
read_manager_maintenance(){
	local choice
	read -p "Enter choice " choice
	case $choice in
    1) stop_All_Nodes
    download_coinfiles
    start_All_Nodes
    echo "Wallet Update should be complete"
    pause ;;
    b) echo ;;
    B) echo ;;
    x) exit 0;;
    X) exit 0;;
		*) echo -e "${RED}Error...${STD}" ${CLEAR} && sleep 2
	esac
}
#End - manager_maintenance read options
#start_masternodes_Menu
manager_Start_Masternodes(){
  clear
  echo "~~~~~~~~~~~~~~~~~~~~~"
  echo "   Start Masternode(s)"
  echo "~~~~~~~~~~~~~~~~~~~~~"
  if [ -d /home/${COINl} ]; then
  echo -e "L - Legacy Masternode One Status"
  fi
  if [ -d /home/${COINl}1 ]; then
  echo -e "01 - (Not This one, you have legacy) (1.0 and new install)"
  fi
  if [ -d /home/${COINl}2 ]; then
  echo -e "02 - Masternode Two"
  fi
  if [ -d /home/${COINl}3 ]; then
  echo -e "03 - Masternode Three"
  fi
  if [ -d /home/${COINl}4 ]; then
  echo -e "04 - Masternode Four"
  fi
  if [ -d /home/${COINl}5 ]; then
  echo -e "05 - Masternode Five"
  fi
  if [ -d /home/${COINl}6 ]; then
  echo -e "06 - Masternode Six"
  fi
  if [ -d /home/${COINl}7 ]; then
  echo -e "07 - Masternode Seven"
  fi
  if [ -d /home/${COINl}8 ]; then
  echo -e "08 - Masternode Eight"
  fi
  if [ -d /home/${COINl}9 ]; then
  echo -e "09 - Masternode Nine"
  fi
  if [ -d /home/${COINl}0 ]; then
  echo -e "10 - Masternode Ten"
  fi
  echo -e "A - Start All ${COIN3} Masternodes"
  echo -e "B - Back out of Menu"
  echo -e "X - Exit"
  read_Start_Masternodes
}
#start - read Start Masternodes Menu
read_Start_Masternodes(){
  local choice
	read -p "Enter choice " choice
  case $choice in
    l) nodeunit=
    start_masternode ;;
    1) nodeunit=1
    start_masternode ;;
    2) nodeunit=2
    start_masternode ;;
    3) nodeunit=3
    start_masternode ;;
    4) nodeunit=4
    start_masternode ;;
    5) nodeunit=5
    start_masternode ;;
    6) nodeunit=6
    start_masternode ;;
    7) nodeunit=7
    start_masternode ;;
    8) nodeunit=8
    start_masternode ;;
    9) nodeunit=9
    start_masternode ;;
    10) nodeunit=0
    start_masternode ;;
    a) echo -e "Launching all Masters!"
    start_All_Nodes ;;
    A) echo -e "Launching all Masters!"
    start_All_Nodes ;;
    b) echo -e "backing out" ;;
    B) echo -e "backing out" ;;
    x) exit 0;;
    X) exit 0;;
    *) echo -e "${RED}Error...${STD}" ${CLEAR} && sleep 2
  esac
}
#End - read Start Masternodes Menu


#start function_menu_Reindex_Masternodes
function_menu_Reindex_Masternodes(){
  clear
  echo "~~~~~~~~~~~~~~~~~~~~~"
  echo "   Re-Index Masternode(s)"
  echo "~~~~~~~~~~~~~~~~~~~~~"
  if [ -d /home/${COINl} ]; then
  echo -e "L - Legacy Masternode One Status"
  fi
  if [ -d /home/${COINl}1 ]; then
  echo -e "01 - Masternode One (1.0 and new install)"
  fi
  if [ -d /home/${COINl}2 ]; then
  echo -e "02 - Masternode Two"
  fi
  if [ -d /home/${COINl}3 ]; then
  echo -e "03 - Masternode Three"
  fi
  if [ -d /home/${COINl}4 ]; then
  echo -e "04 - Masternode Four"
  fi
  if [ -d /home/${COINl}5 ]; then
  echo -e "05 - Masternode Five"
  fi
  if [ -d /home/${COINl}6 ]; then
  echo -e "06 - Masternode Six"
  fi
  if [ -d /home/${COINl}7 ]; then
  echo -e "07 - Masternode Seven"
  fi
  if [ -d /home/${COINl}8 ]; then
  echo -e "08 - Masternode Eight"
  fi
  if [ -d /home/${COINl}9 ]; then
  echo -e "09 - Masternode Nine"
  fi
  if [ -d /home/${COINl}0 ]; then
  echo -e "10 - Masternode Ten"
  fi
  #echo -e "A - Re-Index All ${COIN3} Masternodes"
  echo -e "B - Back out of Menu"
  echo -e "X - Exit"
  function_Read_Reindex_Masternodes
}
#end function_menu_Reindex_Masternodes
#start - read Start Masternodes Menu
function_Read_Reindex_Masternodes(){
  local choice
	read -p "Enter choice " choice
  case $choice in
    l) nodeunit=
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
    10) nodeunit=0
    function_reindex_masternode ;;
    a) echo -e "Launching all Masters!"
    start_All_Nodes ;;
    A) echo -e "Launching all Masters!"
    start_All_Nodes ;;
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
  stop_masternode
  echo -e ${GREEN}"Attempting Re-Indexing of Masternode ${nodeunit}" ${CLEAR}
  echo -e "Please wait" ${YELLOW}
  ${COINDAEMON} -datadir=${COINHOME}${nodeunit}/${COINCORE} -reindex
  sleep 15
  echo -e ${CLEAR}
else
  echo -e "Here be dragons"
fi
}
## Start ALL MN function
start_All_Nodes(){
local Count
Count=0
nodeunit=
start_masternode
nodeunit=0
until [[ $nodeunit = 10 ]]; do
start_masternode
nodeunit=$[$nodeunit+1]
done
pause
}
##  end of Start ALL MN function
#start Edit Masternode Status Menu
Edit_MN_Status(){
  clear
  echo "~~~~~~~~~~~~~~~~~~~~~"
	echo "   Edit Masternode Configuration"
	echo "~~~~~~~~~~~~~~~~~~~~~"
  if [ -d /home/${COINl} ]; then
  echo -e "L - Legacy Masternode One Status"
  fi
  if [ -d /home/${COINl}1 ]; then
  echo -e "01 - (Not This one, you have legacy) (1.0 and new install)"
  fi
  if [ -d /home/${COINl}2 ]; then
  echo -e "02 - Masternode Two"
  fi
  if [ -d /home/${COINl}3 ]; then
  echo -e "03 - Masternode Three"
  fi
  if [ -d /home/${COINl}4 ]; then
  echo -e "04 - Masternode Four"
  fi
  if [ -d /home/${COINl}5 ]; then
  echo -e "05 - Masternode Five"
  fi
  if [ -d /home/${COINl}6 ]; then
  echo -e "06 - Masternode Six"
  fi
  if [ -d /home/${COINl}7 ]; then
  echo -e "07 - Masternode Seven"
  fi
  if [ -d /home/${COINl}8 ]; then
  echo -e "08 - Masternode Eight"
  fi
  if [ -d /home/${COINl}9 ]; then
  echo -e "09 - Masternode Nine"
  fi
  if [ -d /home/${COINl}0 ]; then
  echo -e "10 - Masternode Ten"
  fi
  echo -e "B - Back out of Menu"
  echo -e "X - Exit"
  edit_MN_Config
}
#stop_masternodes_Menu
manager_stop_Masternodes(){
  clear
  echo "~~~~~~~~~~~~~~~~~~~~~"
  echo "   stop Masternode(s)"
  echo "~~~~~~~~~~~~~~~~~~~~~"
  if [ -d /home/${COINl} ]; then
  echo -e "L - Legacy Masternode One Status"
  fi
  if [ -d /home/${COINl}1 ]; then
  echo -e "01 - (Not This one, you have legacy) (1.0 and new install)"
  fi
  if [ -d /home/${COINl}2 ]; then
  echo -e "02 - Masternode Two"
  fi
  if [ -d /home/${COINl}3 ]; then
  echo -e "03 - Masternode Three"
  fi
  if [ -d /home/${COINl}4 ]; then
  echo -e "04 - Masternode Four"
  fi
  if [ -d /home/${COINl}5 ]; then
  echo -e "05 - Masternode Five"
  fi
  if [ -d /home/${COINl}6 ]; then
  echo -e "06 - Masternode Six"
  fi
  if [ -d /home/${COINl}7 ]; then
  echo -e "07 - Masternode Seven"
  fi
  if [ -d /home/${COINl}8 ]; then
  echo -e "08 - Masternode Eight"
  fi
  if [ -d /home/${COINl}9 ]; then
  echo -e "09 - Masternode Nine"
  fi
  if [ -d /home/${COINl}0 ]; then
  echo -e "10 - Masternode Ten"
  fi
  echo -e "A - stop All ${COIN3} Masternodes"
  echo -e "B - Back out of Menu"
  echo -e "X - Exit"
  read_stop_Masternodes
}
#stop - read stop Masternodes Menu
read_stop_Masternodes(){
  local choice
	read -p "Enter choice " choice
  case $choice in
    l) nodeunit=
    stop_masternode ;;
    1) nodeunit=1
    stop_masternode ;;
    2) nodeunit=2
    stop_masternode ;;
    3) nodeunit=3
    stop_masternode ;;
    4) nodeunit=4
    stop_masternode ;;
    5) nodeunit=5
    stop_masternode ;;
    6) nodeunit=6
    stop_masternode ;;
    7) nodeunit=7
    stop_masternode ;;
    8) nodeunit=8
    stop_masternode ;;
    9) nodeunit=9
    stop_masternode ;;
    10) nodeunit=0
    stop_masternode ;;
    a) echo -e "Stopping all Masters!"
    stop_All_Nodes ;;
    B) echo -e "Stopping all Masters!"
    stop_All_Nodes ;;
    b) echo -e "backing out" ;;
    B) echo -e "backing out" ;;
    x) exit 0;;
    X) exit 0;;
    *) echo -e "${RED}Error...${STD}" ${CLEAR} && sleep 2
  esac
}
#End - read stop Masternodes Menu
## stop ALL MN function
stop_All_Nodes(){
local Count
Count=0
nodeunit=
stop_masternode
nodeunit=0
until [[ $nodeunit = 10 ]]; do
stop_masternode
nodeunit=$[$nodeunit+1]
done
pause
}
##  end of stop ALL MN function
#Function set for Edit MN Config Menu
edit_menu_choice(){
  if [ -d /home/${COINl}${nodeunit} ]; then
    clear
    echo -e "Stopping Masternode to Prevent Problems, please wait"
    stop_masternode
    edit_masternode
    start_masternode
  else
    echo -e "Here be dragons!"
  fi
}
edit_MN_Config(){
  local choice
  read -p "Enter choice : " choice
  case $choice in
    l) nodeunit=
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
    10) nodeunit=0
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
  echo "~~~~~~~~~~~~~~~~~~~~~"
	echo "   Displaying display_MN_Status"
	echo "~~~~~~~~~~~~~~~~~~~~~"
  if [ -d /home/${COINl} ]; then
  echo -e "L - Legacy Masternode One Status"
  fi
  if [ -d /home/${COINl}1 ]; then
  echo -e "01 - (Not This one, you have legacy) (1.0 and new install)"
  fi
  if [ -d /home/${COINl}2 ]; then
  echo -e "02 - Masternode Two"
  fi
  if [ -d /home/${COINl}3 ]; then
  echo -e "03 - Masternode Three"
  fi
  if [ -d /home/${COINl}4 ]; then
  echo -e "04 - Masternode Four"
  fi
  if [ -d /home/${COINl}5 ]; then
  echo -e "05 - Masternode Five"
  fi
  if [ -d /home/${COINl}6 ]; then
  echo -e "06 - Masternode Six"
  fi
  if [ -d /home/${COINl}7 ]; then
  echo -e "07 - Masternode Seven"
  fi
  if [ -d /home/${COINl}8 ]; then
  echo -e "08 - Masternode Eight"
  fi
  if [ -d /home/${COINl}9 ]; then
  echo -e "09 - Masternode Nine"
  fi
  if [ -d /home/${COINl}0 ]; then
  echo -e "10 - Masternode Ten"
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
# Test Function for Find masterNode
read_Find_MN_Status(){
  local choice
	read -p "Enter choice : " choice
	case $choice in
    l) nodeunit=
    find_Masternodes ;;
    1) nodeunit=1
    find_Masternodes ;;
    2) nodeunit=2
    find_Masternodes ;;
    3) nodeunit=3
    find_Masternodes ;;
    4) nodeunit=4
    find_Masternodes ;;
    5) nodeunit=5
    find_Masternodes ;;
    6) nodeunit=6
    find_Masternodes ;;
    7) nodeunit=7
    find_Masternodes ;;
    8) nodeunit=8
    find_Masternodes ;;
    9) nodeunit=9
    find_Masternodes ;;
    10) nodeunit=0
    find_Masternodes ;;
    b) echo -e "backing out" ;;
    B) echo -e "backing out" ;;
    x) exit 0;;
    X) exit 0;;
		*) echo -e "${RED}Error...${STD}" ${CLEAR} && sleep 2
	esac
}
#end find test masternode menu
find_Masternodes(){
local Count
Count=0
nodeunit=
function_find_Masternodes
nodeunit=0
until [[ $nodeunit = 10 ]]; do
function_find_Masternodes
nodeunit=$[$nodeunit+1]
#if [ ${nodeunit} -eq "4" ]; then
#  pause
#fi
done
pause
}
# Find Masternode Test Function
function_find_Masternodes(){
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
        y) start_masternode ;;
        Y) start_masternode ;;
        n) echo -e "backing out" ;;
        N) echo -e "backing out" ;;
        *) echo -e "${RED}Error...${STD}" ${CLEAR} && sleep 2
      esac
    fi
      ${COINDAEMONCLI} -datadir=${COINHOME}${nodeunit}/${COINCORE} masternode status &> ${DPATH}XGSMN${nodeunit}.tmp
      DISPIP=$(sed -n '4p' < /usr/local/nullentrydev/XGSMN${nodeunit}.tmp | cut -d'"' -f4 | cut -d':' -f1)
        if [[ "$DISPIP" =~ (([01]{,1}[0-9]{1,2}|2[0-4][0-9]|25[0-5])\.([01]{,1}[0-9]{1,2}|2[0-4][0-9]|25[0-5])\.([01]{,1}[0-9]{1,2}|2[0-4][0-9]|25[0-5])\.([01]{,1}[0-9]{1,2}|2[0-4][0-9]|25[0-5]))$ ]]; then
          echo -e "Running on IPv4 :${YELLOW} ${DISPIP}" ${CLEAR}
        else
        DISPIP=$(sed -n '4p' < /usr/local/nullentrydev/XGSMN${nodeunit}.tmp | cut -d'"' -f4 | cut -d':' -f1-8)
          echo -e "Running on IPv6 : ${YELLOW} ${DISPIP}" ${CLEAR}
        fi
        rm -r /usr/local/nullentrydev/XGSMN${nodeunit}.tmp
#        echo "Running on IP : ${DISPIP}"
XGSOld="1"
XGS=$XGS+1
#else
#  if [ ! -z ${nodeunit} ]; then
# echo -e ${RED}"No Installation Found for Masternode ${nodeunit} - /home/${COINl}${nodeunit}" ${CLEAR}
#  fi
fi
echo
}
precheck_install(){
  local NULLREC
  # Permission to Store/Make nullentrydev files ####
  echo
  echo -e ${BLUE}"May this script will store a small amount data in /usr/local/nullentrydev/ ?"${CLEAR}
  echo -e ${BLUE}"This information is for version updates and later implimentation"${CLEAR}
  echo -e ${BLUE}"Zero Confidental information or Wallet keys will be stored in it"${CLEAR}
  echo -e ${YELLOW}"Press Y to agree, or N [ENTER] to disagree and cancel"${CLEAR}
  read  -p "Enter choice : " NULLREC
  case $NULLREC in
    y) echo proceeding ;;
    Y) echo proceeding ;;
    n) exit 0 ;;
    N) exit 0 ;;
    *) echo -e "${RED}Error...${STD}" ${CLEAR} && sleep 2 && precheck_install
  esac
}
#start function_update
function_update() {
    echo -e ${RED}"Updating Apps"${CLEAR}
    sudo apt-get -y update
    sudo apt-get -y upgrade
}
# Operating Systems Check
first_run(){
  if grep -Fxq "firstrun_complete: true" /usr/local/nullentrydev/mnodes.log
    then
      echo "Not First Run - Testing Check Point"
    else
        if [[ $(lsb_release -d) != *16.04* ]]; then
          echo -e ${RED}"The operating system is not Ubuntu 16.04. You must be running on ubuntu 16.04."${CLEAR}
          exit 1
        fi
  ## precheck_install <<<<<<<<<<<<<<<<>>>>>>>> UNCOMMENT out later this needs to be moved to an installer process
#Null Entry Logs configuration file check
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
        echo "firstrun_complete: true" /usr/local/nullentrydev/mnodes.log
    fi
#function_update #remove is placed elsewhere
# Checking to see if Dependencies & Software Libraries have been installed
if grep -Fxq "dependenciesInstalled: true" /usr/local/nullentrydev/mnodes.log
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
  echo -e ${RED}"Press ENTER when prompted"${CLEAR}
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
}
#### end apps/update  install functions?
#>>>>>>>>>><<<<<<<<<<<<<<  make function for IP tables
### Start Building IP Tables function
function_iptables(){
  #Building IP Table
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
    read MNIP9
    else
    regex='^([0-9a-fA-F]{0,4}:){1,7}[0-9a-fA-F]{0,4}$'
    FINDIP=$(hostname -I | cut -f2 -d' '| cut -f1-7 -d:)
    if [[ $FINDIP =~ $regex ]]; then
    echo "IPv6 Address check is good"
    IP=${FINDIP}
    echo ${IP}
    else
    echo "IPv6 Address check is not expected, getting IPv6 Helper to recalculate"
    sudo apt-get install sipcalc
    FINDIP=$(hostname -I | cut -f3 -d' '| cut -f1-8 -d:)
    echo "Attempting to adjust results and re-calculate IPv6 Address"
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
    sudo touch ${DPATH}ip.tmp
    for i in {15361..15375}; do printf "${IP}:%.4x\n" $i >> ${DPATH}ip.tmp; done
    MNIP1=$(hostname  -I | cut -f1 -d' ') # make Lead IP IPv4 for node
    MNIP2=$(sed -n '2p' < ${DPATH}ip.tmp)
    MNIP3=$(sed -n '3p' < ${DPATH}ip.tmp)
    MNIP4=$(sed -n '4p' < ${DPATH}ip.tmp)
    MNIP5=$(sed -n '5p' < ${DPATH}ip.tmp)
    MNIP6=$(sed -n '6p' < ${DPATH}ip.tmp)
    MNIP7=$(sed -n '7p' < ${DPATH}ip.tmp)
    MNIP8=$(sed -n '8p' < ${DPATH}ip.tmp)
    MNIP9=$(sed -n '9p' < ${DPATH}ip.tmp)
    MNIP0=$(sed -n '10p' < ${DPATH}ip.tmp)
    rm -rf ${DPATH}ip.tmp
    fi
}
#end function_iptables
#>>>>>>>>>><<<<<<<<<<< break into function, swap space >>>>>>>>>>>><<<<<<<<<<<<<<<<<
#start function_swap_space
function_swap_space(){
if grep -Fxq "swapInstalled: true" /usr/local/nullentrydev/mnodes.log
then
echo -e ${RED}"Skipping... Swap Area already made"${CLEAR}
else
cd /var
sudo touch swap.img
sudo chmod 600 swap.img
echo -e ${YELLOW} "You should check out https://youtu.be/l9nh1l8ZIJQ"${CLEAR}
sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=4096
sudo mkswap /var/swap.img
sudo swapon /var/swap.img
fi
}
###end test find masternode function
download_coinfiles(){
  cd ~
if [ ! -d /root/${COIN3l} ]; then
  sudo mkdir /root/${COIN3l}
fi
cd /root/${COIN3l}
#Download Wallet Files
echo "Downloading latest ${COIN} binaries"
wget  https://github.com/genesisx/BitcoinGenesisX/files/2853315/genesisx-linux.zip
unzip genesisx-linux.zip
sleep 3
sudo mv /root/${COIN3l}/${COINDAEMON} /root/${COIN3l}/${COINDAEMONCLI} /usr/local/bin
sudo chmod 755 -R  /usr/local/bin/${COINl}*
rm -rf /root/${COIN3l}
}
##Make Node configuration file
build_first_node(){
  echo -e "${GREEN}Configuring First ${COIN} Node${CLEAR}"
  sudo mkdir /home/${COINl}/.${COINl}
  sudo touch /home/${COINl}/.${COINl}/${COINCONFIG}
  echo "rpcuser=user"`shuf -i 100000-9999999 -n 1` >> /home/${COINl}/.${COINl}/${COINCONFIG}
  echo "rpcpassword=pass"`shuf -i 100000-9999999 -n 1` >> /home/${COINl}/.${COINl}/${COINCONFIG}
  echo "rpcallowip=127.0.0.1" >> /home/${COINl}/.${COINl}/${COINCONFIG}
  echo "server=1" >> /home/${COINl}/.${COINl}/${COINCONFIG}
  echo "daemon=1" >> /home/${COINl}/.${COINl}/${COINCONFIG}
  echo "maxconnections=250" >> /home/${COINl}/.${COINl}/${COINCONFIG}
  echo "masternode=1" >> /home/${COINl}/.${COINl}/${COINCONFIG}
  echo "rpcport=${COINRPCPORT1}" >> /home/${COINl}/.${COINl}/${COINCONFIG}
  echo "listen=0" >> /home/${COINl}/.${COINl}/${COINCONFIG}
  echo "externalip=[${MNIP1}]:$COINPORT" >> /home/${COINl}/.${COINl}/${COINCONFIG}
  echo "masternodeprivkey=$privkey" >> /home/${COINl}/.${COINl}/${COINCONFIG}
  echo "addnode=85.214.50.43:4488" >> /home/${COINl}/.${COINl}/${COINCONFIG}
  echo "addnode=45.32.128.115:4488" >> /home/${COINl}/.${COINl}/${COINCONFIG}
  echo "addnode=144.202.124.138:4488" >> /home/${COINl}/.${COINl}/${COINCONFIG}
  echo "addnode=108.61.224.80:4488" >> /home/${COINl}/.${COINl}/${COINCONFIG}
  echo "addnode=118.38.99.125:4488" >> /home/${COINl}/.${COINl}/${COINCONFIG}
  echo "addnode=178.62.68.177:4488" >> /home/${COINl}/.${COINl}/${COINCONFIG}
  echo "addnode=136.61.3.89:4488" >> /home/${COINl}/.${COINl}/${COINCONFIG}
}
## End Make Node Configuration Files
## Start Launch First node
launch_first_node(){
  echo -e ${BOLD}"Launching First ${COIN3} Node"${CLEAR}
  ${COINDAEMON} -datadir=/home/${COINl}/.${COINl} -daemon
  sleep 1
    if [ -f /usr/local/nullentrydev/${COIN3l}.log ]; then
      sudo rm -rf /usr/local/nullentrydev/${COIN3l}.log
      sudo touch /usr/local/nullentrydev/${COIN3l}.log
    fi
    echo "masterNode1 : true" >> /usr/local/nullentrydev/${COIN3l}.log
    echo "walletVersion1 : $COINVERSION" >> /usr/local/nullentrydev/${COIN3l}.log
    echo "scriptVersion1 : $SCRIPTVERSION" >> /usr/local/nullentrydev/${COIN3l}.log
}
##End Launch first node
##Start Waiting for Launch of First Nodes
wait_first_node_launch(){
echo
echo -e "${RED}This process can take a while!${CLEAR}"
echo -e "${YELLOW}Waiting on First Masternode Block Chain to Synchronize${CLEAR}"
echo -e "${YELLOW}Once complete, it will stop and copy the block chain to${CLEAR}"
echo -e "${YELLOW}the other masternodes.  This prevent all masternodes${CLEAR}"
echo -e "${YELLOW}from downloading the block chain individually; taking up${CLEAR}"
echo -e "${YELLOW}more time and resources.  Current Block count will be displayed below.${CLEAR}"
genesisx-cli -datadir=/home/genesisx/.genesisx getblockcount
sleep 5
#node 1 sync check
until genesisx-cli -datadir=/home/genesisx/.genesisx mnsync status | grep -m 1 'IsBlockchainSynced" : true'; do
    genesisx-cli -datadir=/home/genesisx/.genesisx getblockcount
    sleep 5
  done
}
##End launch of first nodes
##Start of replicate nodes
replicate_node(){
  echo -e "${GREEN}Haulting and Replicating First ${COIN} Node${CLEAR}"
  echo
  sleep 5
  cd /
  genesisx-cli -datadir=/home/genesisx/.genesisx stop
  sleep 10
  sudo cp -r /home/${COINl}/.${COINl}/* /home/${COINl}2/.${COINl}/
  sudo cp -r /home/${COINl}/.${COINl}/* /home/${COINl}3/.${COINl}/
  sudo cp -r /home/${COINl}/.${COINl}/* /home/${COINl}4/.${COINl}/
  sudo cp -r /home/${COINl}/.${COINl}/* /home/${COINl}5/.${COINl}/
  sudo cp -r /home/${COINl}/.${COINl}/* /home/${COINl}6/.${COINl}/
  sudo cp -r /home/${COINl}/.${COINl}/* /home/${COINl}7/.${COINl}/
  sudo cp -r /home/${COINl}/.${COINl}/* /home/${COINl}8/.${COINl}/
  sudo rm /home/${COINl}2/.${COINl}/${COINCONFIG}
  sudo rm /home/${COINl}3/.${COINl}/${COINCONFIG}
  sudo rm /home/${COINl}4/.${COINl}/${COINCONFIG}
  sudo rm /home/${COINl}5/.${COINl}/${COINCONFIG}
  sudo rm /home/${COINl}6/.${COINl}/${COINCONFIG}
  sudo rm /home/${COINl}7/.${COINl}/${COINCONFIG}
  sudo rm /home/${COINl}8/.${COINl}/${COINCONFIG}
  sudo cp -r /home/${COINl}2/${COINCONFIG} /home/${COINl}2/.${COINl}/${COINCONFIG}
  sudo cp -r /home/${COINl}3/${COINCONFIG} /home/${COINl}3/.${COINl}/${COINCONFIG}
  sudo cp -r /home/${COINl}4/${COINCONFIG} /home/${COINl}4/.${COINl}/${COINCONFIG}
  sudo cp -r /home/${COINl}5/${COINCONFIG} /home/${COINl}5/.${COINl}/${COINCONFIG}
  sudo cp -r /home/${COINl}6/${COINCONFIG} /home/${COINl}6/.${COINl}/${COINCONFIG}
  sudo cp -r /home/${COINl}7/${COINCONFIG} /home/${COINl}7/.${COINl}/${COINCONFIG}
  sudo cp -r /home/${COINl}8/${COINCONFIG} /home/${COINl}8/.${COINl}/${COINCONFIG}
  sleep 5
start_All_Nodes
}
##Configure other nodes
configure_nonleadNodes(){
  echo
echo -e "${GREEN}Configuring Second ${COIN} Node${CLEAR}"
sudo mkdir /home/${COINl}2/.${COINl}
sudo touch /home/${COINl}2/${COINCONFIG}
echo "rpcuser=user"`shuf -i 100000-9999999 -n 1` >> /home/${COINl}2/${COINCONFIG}
echo "rpcpassword=pass"`shuf -i 100000-9999999 -n 1` >> /home/${COINl}2/${COINCONFIG}
echo "rpcallowip=127.0.0.1" >> /home/${COINl}2/${COINCONFIG}
echo "server=1" >> /home/${COINl}2/${COINCONFIG}
echo "daemon=1" >> /home/${COINl}2/${COINCONFIG}
echo "maxconnections=250" >> /home/${COINl}2/${COINCONFIG}
echo "masternode=1" >> /home/${COINl}2/${COINCONFIG}
echo "rpcport=${COINRPCPORT2}" >> /home/${COINl}2/${COINCONFIG}
echo "listen=0" >> /home/${COINl}2/${COINCONFIG}
echo "externalip=[${MNIP2}]:$COINPORT" >> /home/${COINl}2/${COINCONFIG}
echo "masternodeprivkey=$privkey2" >> /home/${COINl}2/${COINCONFIG}
# Inserting Version to nullentrydev files
if [[ $NULLREC = "y" ]] ; then
  echo "masterNode2 : true" >> /usr/local/nullentrydev/${COIN3l}.log
  echo "walletVersion2 : $COINVERSION" >> /usr/local/nullentrydev/${COIN3l}.log
  echo "scriptVersion2 : $SCRIPTVERSION" >> /usr/local/nullentrydev/${COIN3l}.log
fi
sleep 3
echo
# Starting Second Masternode daemon
echo -e ${BOLD}"Second ${COIN3} Node Staged for launch"${CLEAR}
}
donate_address(){
echo -e ${BLUE}" Your patronage is apprappreciated, tipping addresses"${CLEAR}
echo -e ${BLUE}" BGX address: BoEsUmcS3D9gVmdxvj7Che4wD1SAHa2zG9"${CLEAR}
echo -e ${BLUE}" LTC address: MUdDdVr4Az1dVw47uC4srJ31Ksi5SNkC7H"${CLEAR}
echo -e ${BLUE}" BTC address: 32FzghE1yUZRdDmCkj3bJ6vJyXxUVPKY93"${CLEAR}
echo
echo -e ${YELLOW}"Need help?  Find Sburns1369#1584 one Discord - https://discord.gg/YhJ8v3g"${CLEAR}
}
### Start - Masternode function_calculate_Masternode_Install
function_new_masternode_install_menu(){
  echo -e ${GREEN}" How many ${COIN3} Masternode(s) would you like to Install? [1 - 10]"${CLEAR}
  echo -e "Press [C] to exit"
  read -p "Enter Number : " Install_Count
  case $Install_Count in
    1-10) echo "test fire ${Install_Count}" ;;
    c) exit 0 ;;
    c) exit 0 ;;
    *) echo -e "${RED}Invalid Amount!${STD}" ${CLEAR} && sleep 2
  esac
  #set permaters to install
}
### End -  Masternode function_calculate_Masternode_Install
### Start - Masternode function_Masternode_upgrade
function_masternode_upgrade(){
  #subtracts currently running masternodes
echo null
  #ask how many masternodes to add
  #set permaters to install
}
function_masternode_migrate(){
  #attempt to move legacy masternode
  echo null#possible attempt to relocate stock scripts
}
### End - Masternode function_Masternode_upgrade
#Program Core
clear
null_logo
GenesisX_Logo
BitCoinGenX_Logo
first_run
while true
do
	show_mainMenu
  echo
done
