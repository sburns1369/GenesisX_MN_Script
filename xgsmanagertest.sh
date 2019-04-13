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
echo "    ███╗   ██╗██╗   ██╗██╗     ██╗     ███████╗███╗   ██╗████████╗██████╗ ██╗   ██╗    ";
echo "    ████╗  ██║██║   ██║██║     ██║     ██╔════╝████╗  ██║╚══██╔══╝██╔══██╗╚██╗ ██╔╝    ";
echo "    ██╔██╗ ██║██║   ██║██║     ██║     █████╗  ██╔██╗ ██║   ██║   ██████╔╝ ╚████╔╝     ";
echo "    ██║╚██╗██║██║   ██║██║     ██║     ██╔══╝  ██║╚██╗██║   ██║   ██╔══██╗  ╚██╔╝      ";
echo "    ██║ ╚████║╚██████╔╝███████╗███████╗███████╗██║ ╚████║   ██║   ██║  ██║   ██║       ";
echo "    ╚═╝  ╚═══╝ ╚═════╝ ╚══════╝╚══════╝╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚═╝  ╚═╝   ╚═╝       ";
echo "                                                                                       ";
echo "███╗   ███╗ █████╗ ███████╗████████╗███████╗██████╗ ███╗   ██╗ █████╗ ██████╗ ███████╗";
echo "████╗ ████║██╔══██╗██╔════╝╚══██╔══╝██╔════╝██╔══██╗████╗  ██║██╔══██╗██╔══██╗██╔════╝";
echo "██╔████╔██║███████║███████╗   ██║   █████╗  ██████╔╝██╔██╗ ██║██║  ██║██║  ██║█████╗  ";
echo "██║╚██╔╝██║██╔══██║╚════██║   ██║   ██╔══╝  ██╔══██╗██║╚██╗██║██║  ██║██║  ██║██╔══╝  ";
echo "██║ ╚═╝ ██║██║  ██║███████║   ██║   ███████╗██║  ██║██║ ╚████║╚█████╔╝██████╔╝███████╗";
echo "╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚════╝ ╚═════╝ ╚══════╝";
echo "                                                                                       ";
echo "            ███╗   ███╗ █████╗ ███╗   ██╗ █████╗  ██████╗ ███████╗██████╗              ";
echo "            ████╗ ████║██╔══██╗████╗  ██║██╔══██╗██╔════╝ ██╔════╝██╔══██╗             ";
echo "            ██╔████╔██║███████║██╔██╗ ██║███████║██║  ███╗█████╗  ██████╔╝             ";
echo "            ██║╚██╔╝██║██╔══██║██║╚██╗██║██╔══██║██║   ██║██╔══╝  ██╔══██╗             ";
echo "            ██║ ╚═╝ ██║██║  ██║██║ ╚████║██║  ██║╚██████╔╝███████╗██║  ██║             ";
echo "            ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝             ";
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
  echo -e "${CLEAR}                                                           ";
  echo
  echo
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
		2) status_XGSMasternodes ;;
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
  echo -e "5 - Rebuild Chain (Not Implimented)"
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
    x) exit 0;;
		*) echo -e "${RED}Error...${STD}" ${CLEAR} && sleep 2
	esac
}
## end MN Start Menu options
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

# Operating Systems Check
first_run(){
  if [[ $(lsb_release -d) != *16.04* ]]; then
    echo -e ${RED}"The operating system is not Ubuntu 16.04. You must be running on ubuntu 16.04."${CLEAR}
    exit 1
  fi
  precheck_install
#Null Entry Logs configuration file check
  if [ ! -d /usr/local/nullentrydev/ ]; then
    echo "Making /usr/local/nullentrydev "
    sudo mkdir /usr/local/nullentrydev
  else
    echo "Found /usr/local/nullentrydev "
  fi
###end test find masternode function
#Program Core
}
clear
null_logo
GenesisX_Logo
first_run
while true
do
	show_mainMenu
  echo
done
