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
#Main menu
show_mainMenu() {
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~"
	echo " M A I N - M E N U"
	echo "~~~~~~~~~~~~~~~~~~~~~"
  echo -e "1 - My Masternode(s) Status"
  echo -e "2 - Install or Add Masternodes"
  echo -e "3 - Masternode Manager"
  echo -e "4 - Donate - test for find"
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
		*) echo -e "${RED}Error...${STD}" && sleep 2
	esac
}
#start Masternode
start_masternode(){
  echo -e ${GREEN}"Starting Masternode ${nodeunit}" ${CLEAR}
  echo -e "Please wait" ${YELLOW}
${COINDAEMON} -datadir=${COINHOME}${nodeunit}/${COINCORE} -daemon
sleep 15
echo -e ${CLEAR}
}
#start Masternode
stop_masternode(){
  echo -e ${GREEN}"Stopping Masternode ${nodeunit}" ${YELLOW}
securecloud-cli -datadir=${COINHOME}${nodeunit}/${COINCORE} stop
sleep 15
echo -e ${CLEAR}
}
#edit Masternode Configuration
edit_masternode(){
  echo -e ${GREEN}"Editing Masternode ${nodeunit} Configuration" ${CLEAR}
  echo -e ${GREEN}"Use [Control Key] + [X Key] to exit editting" ${CLEAR}
  echo -e ${GREEN}"Press [N Key] to Abort Changes in editor" ${CLEAR}
  echo -e ${GREEN}"Or press [Y Key] to Save Changes" ${CLEAR}
  echo -e ${GREEN}"Than [Enter Key] to Accept Changes to File Name" ${CLEAR}
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
  echo -e "5 - Rebuild Chain"
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
    x) exit 0;;
		*) echo -e "${RED}Error...${STD}" ${CLEAR} && sleep 2
	esac
}
Edit_MN_Status(){
  clear
  echo "~~~~~~~~~~~~~~~~~~~~~"
	echo "   Edit Masternode Configuration"
	echo "~~~~~~~~~~~~~~~~~~~~~"
  echo -e "01 - Masternode One (1.0 and new install)"
  echo -e "02 - Masternode Two"
  echo -e "03 - Masternode Three"
  echo -e "04 - Masternode Four"
  echo -e "05 - Masternode Five"
  echo -e "06 - Masternode Six"
  echo -e "07 - Masternode Seven"
  echo -e "08 - Masternode Eight"
  echo -e "09 - Masternode Nine"
  echo -e "10 - Masternode Ten"
  echo -e "L - Legacy Masternode One Status"
  echo -e "B - Back out of Menu"
  echo -e "X - Exit"
  edit_MN_Config
}
#Function set for Edit MN Config Menu
edit_menu_choice(){
  clear
  echo -e "Stopping Masternode to Prevent "
  stop_masternode
  edit_masternode
  start_masternode
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
  echo -e "01 - Masternode One (1.0 and new install)"
  echo -e "02 - Masternode Two"
  echo -e "03 - Masternode Three"
  echo -e "04 - Masternode Four"
  echo -e "05 - Masternode Five"
  echo -e "06 - Masternode Six"
  echo -e "07 - Masternode Seven"
  echo -e "08 - Masternode Eight"
  echo -e "09 - Masternode Nine"
  echo -e "10 - Masternode Ten"
  echo -e "L - Legacy Masternode One Status"
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
if [ ${nodeunit} -eq "4" ]; then
  pause
fi
done
pause
}
# Find Masternode Test Function
function_find_Masternodes(){
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
else
  if [ ! -z ${nodeunit} ]; then
echo -e ${RED}"No Installation Found for Masternode ${nodeunit} - /home/${COINl}${nodeunit}" ${CLEAR}
fi
fi
echo
}
###end test find masternode function
#Program Core
while true
do
	show_mainMenu
  echo
done
