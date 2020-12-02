#!/bin/bash
#script_Version:1.5
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
DOWNLOADCOINFILES=http://nullentry.com/chain/XGS/genesisx-1.5.0-linux.zip
COINFILES=genesisx-1.5.0-linux.zip
DECOMPRESS='unzip'
#rocketstrap
NEBootStrap=http://genesisx.network/rocketstrap.rar
AddNodeList=http://nullentry.com/chain/XGS/addnodes.tbl
ADDNODE0=54.36.175.160:5555
ADDNODE1=213.136.90.158:5555
ADDNODE2=5.189.163.30:5555
ADDNODE3=192.99.16.198:5555
ADDNODE4=80.254.127.139:5555
ADDNODE5=93.104.213.205:5555
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
bash <(curl -Ls https://raw.githubusercontent.com/CowsGoWuff/GenesisX30MN/master/null_logo.sh)
pause
}
#genesisx_Logo
Function_Display_Genesisx_Logo(){
  bash <(curl -Ls https://raw.githubusercontent.com/CowsGoWuff/GenesisX30MN/master/logo.sh)
  pause
  }
#Logo(){
Function_Rocket_Delay(){
bash <(curl -Ls https://raw.githubusercontent.com/CowsGoWuff/GenesisX30MN/master/rocket.sh)
}
  ### Start - First Run Configuration
  Function_Check_First_Run(){
  local NULLREC
  if grep -Fxq "${COIN3}firstrun_complete: true" /usr/local/nullentrydev/mnodes.log
    then
      echo "Not First Run"
    else
  bash <(curl -Ls https://raw.githubusercontent.com/CowsGoWuff/GenesisX30MN/master/welcome.sh)
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
  if [ -d /home/${COINl}11 ]; then
  echo -e "11 -  Masternode Elven"
  fi
  if [ -d /home/${COINl}12 ]; then
  echo -e "12 -  Masternode Twelve"
  fi
  if [ -d /home/${COINl}13 ]; then
  echo -e "13 -  Masternode Thirteen"
  fi
  if [ -d /home/${COINl}14 ]; then
  echo -e "14 -  Masternode Fourteen"
  fi
  if [ -d /home/${COINl}15 ]; then
  echo -e "15 -  Masternode Fifteen"
  fi
  if [ -d /home/${COINl}16 ]; then
  echo -e "16 -  Masternode Sixteen"
  fi
  if [ -d /home/${COINl}17 ]; then
  echo -e "17 -  Masternode Seventeen"
  fi
  if [ -d /home/${COINl}18 ]; then
  echo -e "18 -  Masternode Eighteen"
  fi
  if [ -d /home/${COINl}19 ]; then
  echo -e "19 -  Masternode Nineteen"
  fi
  if [ -d /home/${COINl}20 ]; then
  echo -e "20 -  Masternode Twenty"
  fi
  if [ -d /home/${COINl}21 ]; then
  echo -e "21 -  Masternode Twentyone"
  fi
  if [ -d /home/${COINl}22 ]; then
  echo -e "22 -  Masternode Twentytwo"
  fi
  if [ -d /home/${COINl}23 ]; then
  echo -e "23 -  Masternode Twentythree"
  fi
  if [ -d /home/${COINl}24 ]; then
  echo -e "24 -  Masternode Twentyfour"
  fi
  if [ -d /home/${COINl}25 ]; then
  echo -e "25 -  Masternode Twentyfive"
  fi
  if [ -d /home/${COINl}26 ]; then
  echo -e "26 -  Masternode Twentysix"
  fi
  if [ -d /home/${COINl}27 ]; then
  echo -e "27 -  Masternode Twentyseven"
  fi
  if [ -d /home/${COINl}28 ]; then
  echo -e "28 -  Masternode Twentyeight"
  fi
  if [ -d /home/${COINl}29 ]; then
  echo -e "29 -  Masternode Twentynine"
  fi
  if [ -d /home/${COINl}30 ]; then
  echo -e "30 -  Masternode Thirty"
  fi
  if [ -d /home/${COINl}31 ]; then
  echo -e "31 -  Masternode Thirtyone"
  fi
  if [ -d /home/${COINl}32 ]; then
  echo -e "32 -  Masternode Thirtytwo"
  fi
  if [ -d /home/${COINl}33 ]; then
  echo -e "33 -  Masternode Thirtythree"
  fi
  if [ -d /home/${COINl}34 ]; then
  echo -e "34 -  Masternode Thirtyfour"
  fi
  if [ -d /home/${COINl}35 ]; then
  echo -e "35 -  Masternode Thirtyfive"
  fi
  if [ -d /home/${COINl}36 ]; then
  echo -e "36 -  Masternode Thirtysix"
  fi
  if [ -d /home/${COINl}37 ]; then
  echo -e "37 -  Masternode Thirtyseven"
  fi
  if [ -d /home/${COINl}38 ]; then
  echo -e "38 -  Masternode Thirtyeight"
  fi
  if [ -d /home/${COINl}39 ]; then
  echo -e "39 -  Masternode Thirtynine"
  fi
  if [ -d /home/${COINl}40 ]; then
  echo -e "40 -  Masternode Forty"
  fi
  if [ -d /home/${COINl}41 ]; then
  echo -e "41 -  Masternode Fortyone"
  fi
  if [ -d /home/${COINl}42 ]; then
  echo -e "42 -  Masternode Fortytwo"
  fi
  if [ -d /home/${COINl}43 ]; then
  echo -e "43 -  Masternode Fortythree"
  fi
  if [ -d /home/${COINl}44 ]; then
  echo -e "44 -  Masternode Fortyfour"
  fi
  if [ -d /home/${COINl}45 ]; then
  echo -e "45 -  Masternode Fortyfive"
  fi
  if [ -d /home/${COINl}46 ]; then
  echo -e "46 -  Masternode Fortysix"
  fi
  if [ -d /home/${COINl}47 ]; then
  echo -e "47 -  Masternode Fortyseven"
  fi
  if [ -d /home/${COINl}48 ]; then
  echo -e "48 -  Masternode Fortyeight"
  fi
  if [ -d /home/${COINl}49 ]; then
  echo -e "49 -  Masternode Fortynine"
  fi
  if [ -d /home/${COINl}50 ]; then
  echo -e "50 -  Masternode Fifty"
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
    13) nodeunit=13
    Function_Start_Masternode ;;
    14) nodeunit=14
    Function_Start_Masternode ;;
    15) nodeunit=15
    Function_Start_Masternode ;;
    16) nodeunit=16
    Function_Start_Masternode ;;
    17) nodeunit=17
    Function_Start_Masternode ;;
    18) nodeunit=18
    Function_Start_Masternode ;;
    19) nodeunit=19
    Function_Start_Masternode ;;
    20) nodeunit=20
    Function_Start_Masternode ;;
    21) nodeunit=21
    Function_Start_Masternode ;;
    22) nodeunit=22
    Function_Start_Masternode ;;
    23) nodeunit=23
    Function_Start_Masternode ;;
    24) nodeunit=24
    Function_Start_Masternode ;;
    25) nodeunit=25
    Function_Start_Masternode ;;
    26) nodeunit=26
    Function_Start_Masternode ;;
    27) nodeunit=27
    Function_Start_Masternode ;;
    28) nodeunit=28
    Function_Start_Masternode ;;
    29) nodeunit=29
    Function_Start_Masternode ;;
    30) nodeunit=30
    Function_Start_Masternode ;;
    31) nodeunit=31
    Function_Start_Masternode ;;
    32) nodeunit=32
    Function_Start_Masternode ;;
    33) nodeunit=33
    Function_Start_Masternode ;;
    34) nodeunit=34
    Function_Start_Masternode ;;
    35) nodeunit=35
    Function_Start_Masternode ;;
    36) nodeunit=36
    Function_Start_Masternode ;;
    37) nodeunit=37
    Function_Start_Masternode ;;
    38) nodeunit=38
    Function_Start_Masternode ;;
    39) nodeunit=39
    Function_Start_Masternode ;;
    40) nodeunit=40
    Function_Start_Masternode ;;
    41) nodeunit=41
    Function_Start_Masternode ;;
    42) nodeunit=42
    Function_Start_Masternode ;;
    43) nodeunit=43
    Function_Start_Masternode ;;
    44) nodeunit=44
    Function_Start_Masternode ;;
    45) nodeunit=45
    Function_Start_Masternode ;;
    46) nodeunit=46
    Function_Start_Masternode ;;
    47) nodeunit=47
    Function_Start_Masternode ;;
    48) nodeunit=48
    Function_Start_Masternode ;;
    49) nodeunit=49
    Function_Start_Masternode ;;
    50) nodeunit=50
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
  if [ -d /home/${COINl}13 ]; then
  echo -e "13 - Masternode Thirteen"
  fi
  if [ -d /home/${COINl}14 ]; then
  echo -e "14 - Masternode Fourteen"
  fi
  if [ -d /home/${COINl}15 ]; then
  echo -e "15 - Masternode Fifteen"
  fi
  if [ -d /home/${COINl}16 ]; then
  echo -e "16 - Masternode Sixteen"
  fi
  if [ -d /home/${COINl}17 ]; then
  echo -e "17 - Masternode Seventeen"
  fi
  if [ -d /home/${COINl}18 ]; then
  echo -e "18 - Masternode Eightteen"
  fi
  if [ -d /home/${COINl}19 ]; then
  echo -e "19 - Masternode Nineteen"
  fi
  if [ -d /home/${COINl}20 ]; then
  echo -e "20 - Masternode Twenty"
  fi
  if [ -d /home/${COINl}21 ]; then
  echo -e "21 - Masternode Twentyone"
  fi
  if [ -d /home/${COINl}22 ]; then
  echo -e "22 - Masternode Twentytwo"
  fi
  if [ -d /home/${COINl}23 ]; then
  echo -e "23 -  Masternode Twentythree"
  fi
  if [ -d /home/${COINl}24 ]; then
  echo -e "24 -  Masternode Twentyfour"
  fi
  if [ -d /home/${COINl}25 ]; then
  echo -e "25 -  Masternode Twentyfive"
  fi
  if [ -d /home/${COINl}26 ]; then
  echo -e "26 -  Masternode Twentysix"
  fi
  if [ -d /home/${COINl}27 ]; then
  echo -e "27 -  Masternode Twentyseven"
  fi
  if [ -d /home/${COINl}28 ]; then
  echo -e "28 -  Masternode Twentyeight"
  fi
  if [ -d /home/${COINl}29 ]; then
  echo -e "29 -  Masternode Twentynine"
  fi
  if [ -d /home/${COINl}30 ]; then
  echo -e "30 -  Masternode Thirty"
  fi
  if [ -d /home/${COINl}31 ]; then
  echo -e "31 -  Masternode Thirtyone"
  fi
  if [ -d /home/${COINl}32 ]; then
  echo -e "32 -  Masternode Thirtytwo"
  fi
  if [ -d /home/${COINl}33 ]; then
  echo -e "33 -  Masternode Thirtythree"
  fi
  if [ -d /home/${COINl}34 ]; then
  echo -e "34 -  Masternode Thirtyfour"
  fi
  if [ -d /home/${COINl}35 ]; then
  echo -e "35 -  Masternode Thirtyfive"
  fi
  if [ -d /home/${COINl}36 ]; then
  echo -e "36 -  Masternode Thirtysix"
  fi
  if [ -d /home/${COINl}37 ]; then
  echo -e "37 -  Masternode Thirtyseven"
  fi
  if [ -d /home/${COINl}38 ]; then
  echo -e "38 -  Masternode Thirtyeight"
  fi
  if [ -d /home/${COINl}39 ]; then
  echo -e "39 -  Masternode Thirtynine"
  fi
  if [ -d /home/${COINl}40 ]; then
  echo -e "40 -  Masternode Forty"
  fi
  if [ -d /home/${COINl}41 ]; then
  echo -e "41 -  Masternode Fortyone"
  fi
  if [ -d /home/${COINl}42 ]; then
  echo -e "42 -  Masternode Fortytwo"
  fi
  if [ -d /home/${COINl}43 ]; then
  echo -e "43 -  Masternode Fortythree"
  fi
  if [ -d /home/${COINl}44 ]; then
  echo -e "44 -  Masternode Fortyfour"
  fi
  if [ -d /home/${COINl}45 ]; then
  echo -e "45 -  Masternode Fortyfive"
  fi
  if [ -d /home/${COINl}46 ]; then
  echo -e "46 -  Masternode Fortysix"
  fi
  if [ -d /home/${COINl}47 ]; then
  echo -e "47 -  Masternode Fortyseven"
  fi
  if [ -d /home/${COINl}48 ]; then
  echo -e "48 -  Masternode Fortyeight"
  fi
  if [ -d /home/${COINl}49 ]; then
  echo -e "49 -  Masternode Fortynine"
  fi
  if [ -d /home/${COINl}50 ]; then
  echo -e "50 -  Masternode Fifty"
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
    13) nodeunit=13
    function_reindex_masternode ;;
    14) nodeunit=14
    function_reindex_masternode ;;
    15) nodeunit=15
    function_reindex_masternode ;;
    16) nodeunit=16
    function_reindex_masternode ;;
    17) nodeunit=17
    function_reindex_masternode ;;
    18) nodeunit=18
    function_reindex_masternode ;;
    19) nodeunit=19
    function_reindex_masternode ;;
    20) nodeunit=20
    function_reindex_masternode ;;
    21) nodeunit=21
    function_reindex_masternode ;;
    22) nodeunit=22
    function_reindex_masternode ;;
    23) nodeunit=23
    function_reindex_masternode ;;
    24) nodeunit=24
    function_reindex_masternode ;;
    25) nodeunit=25
    function_reindex_masternode ;;
    26) nodeunit=26
    function_reindex_masternode ;;
    27) nodeunit=27
    function_reindex_masternode ;;
    28) nodeunit=28
    function_reindex_masternode ;;
    29) nodeunit=29
    function_reindex_masternode ;;
    30) nodeunit=30
    function_reindex_masternode ;;
    31) nodeunit=31
    function_reindex_masternode ;;
    32) nodeunit=32
    function_reindex_masternode ;;
    33) nodeunit=33
    function_reindex_masternode ;;
    34) nodeunit=34
    function_reindex_masternode ;;
    35) nodeunit=35
    function_reindex_masternode ;;
    36) nodeunit=36
    function_reindex_masternode ;;
    37) nodeunit=37
    function_reindex_masternode ;;
    38) nodeunit=38
    function_reindex_masternode ;;
    39) nodeunit=39
    function_reindex_masternode ;;
    40) nodeunit=40
    function_reindex_masternode ;;
    41) nodeunit=41
    function_reindex_masternode ;;
    42) nodeunit=42
    function_reindex_masternode ;;
    43) nodeunit=43
    function_reindex_masternode ;;
    44) nodeunit=44
    function_reindex_masternode ;;
    45) nodeunit=45
    function_reindex_masternode ;;
    46) nodeunit=46
    function_reindex_masternode ;;
    47) nodeunit=47
    function_reindex_masternode ;;
    48) nodeunit=48
    function_reindex_masternode ;;
    49) nodeunit=49
    function_reindex_masternode ;;
    50) nodeunit=50
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
  until [[ $nodeunit = 51 ]]; do
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
  if [ -d /home/${COINl}13 ]; then
  echo -e "13 - Masternode Thirteen"
  fi
  if [ -d /home/${COINl}14 ]; then
  echo -e "14 - Masternode Fourteen"
  fi
  if [ -d /home/${COINl}15 ]; then
  echo -e "15 - Masternode Fifteen"
  fi
  if [ -d /home/${COINl}16 ]; then
  echo -e "16 - Masternode Sixteen"
  fi
  if [ -d /home/${COINl}17 ]; then
  echo -e "17 - Masternode Seventeen"
  fi
  if [ -d /home/${COINl}18 ]; then
  echo -e "18 - Masternode Eighteen"
  fi
  if [ -d /home/${COINl}19 ]; then
  echo -e "19 - Masternode Nineteen"
  fi
  if [ -d /home/${COINl}20 ]; then
  echo -e "20 - Masternode Twenty"
  fi
  if [ -d /home/${COINl}21 ]; then
  echo -e "21 - Masternode Twentyone"
  fi
  if [ -d /home/${COINl}22 ]; then
  echo -e "22 - Masternode Twentytwo"
  fi
  if [ -d /home/${COINl}23 ]; then
  echo -e "23 -  Masternode Twentythree"
  fi
  if [ -d /home/${COINl}24 ]; then
  echo -e "24 -  Masternode Twentyfour"
  fi
  if [ -d /home/${COINl}25 ]; then
  echo -e "25 -  Masternode Twentyfive"
  fi
  if [ -d /home/${COINl}26 ]; then
  echo -e "26 -  Masternode Twentysix"
  fi
  if [ -d /home/${COINl}27 ]; then
  echo -e "27 -  Masternode Twentyseven"
  fi
  if [ -d /home/${COINl}28 ]; then
  echo -e "28 -  Masternode Twentyeight"
  fi
  if [ -d /home/${COINl}29 ]; then
  echo -e "29 -  Masternode Twentynine"
  fi
  if [ -d /home/${COINl}30 ]; then
  echo -e "30 -  Masternode Thirty"
  fi
  if [ -d /home/${COINl}31 ]; then
  echo -e "31 -  Masternode Thirtyone"
  fi
  if [ -d /home/${COINl}32 ]; then
  echo -e "32 -  Masternode Thirtytwo"
  fi
  if [ -d /home/${COINl}33 ]; then
  echo -e "33 -  Masternode Thirtythree"
  fi
  if [ -d /home/${COINl}34 ]; then
  echo -e "34 -  Masternode Thirtyfour"
  fi
  if [ -d /home/${COINl}35 ]; then
  echo -e "35 -  Masternode Thirtyfive"
  fi
  if [ -d /home/${COINl}36 ]; then
  echo -e "36 -  Masternode Thirtysix"
  fi
  if [ -d /home/${COINl}37 ]; then
  echo -e "37 -  Masternode Thirtyseven"
  fi
  if [ -d /home/${COINl}38 ]; then
  echo -e "38 -  Masternode Thirtyeight"
  fi
  if [ -d /home/${COINl}39 ]; then
  echo -e "39 -  Masternode Thirtynine"
  fi
  if [ -d /home/${COINl}40 ]; then
  echo -e "40 -  Masternode Forty"
  fi
  if [ -d /home/${COINl}41 ]; then
  echo -e "41 -  Masternode Fortyone"
  fi
  if [ -d /home/${COINl}42 ]; then
  echo -e "42 -  Masternode Fortytwo"
  fi
  if [ -d /home/${COINl}43 ]; then
  echo -e "43 -  Masternode Fortythree"
  fi
  if [ -d /home/${COINl}44 ]; then
  echo -e "44 -  Masternode Fortyfour"
  fi
  if [ -d /home/${COINl}45 ]; then
  echo -e "45 -  Masternode Fortyfive"
  fi
  if [ -d /home/${COINl}46 ]; then
  echo -e "46 -  Masternode Fortysix"
  fi
  if [ -d /home/${COINl}47 ]; then
  echo -e "47 -  Masternode Fortyseven"
  fi
  if [ -d /home/${COINl}48 ]; then
  echo -e "48 -  Masternode Fortyeight"
  fi
  if [ -d /home/${COINl}49 ]; then
  echo -e "49 -  Masternode Fortynine"
  fi
  if [ -d /home/${COINl}50 ]; then
  echo -e "50 -  Masternode Fifty"
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
  if [ -d /home/${COINl}11 ]; then
  echo -e "11 - Masternode Eleven"
  fi
  if [ -d /home/${COINl}12 ]; then
  echo -e "12 - Masternode Twelve"
  fi
  if [ -d /home/${COINl}13 ]; then
  echo -e "13 - Masternode Thirteen"
  fi
  if [ -d /home/${COINl}14 ]; then
  echo -e "14 - Masternode Fourteen"
  fi
  if [ -d /home/${COINl}15 ]; then
  echo -e "15 - Masternode Fifteen"
  fi
  if [ -d /home/${COINl}16 ]; then
  echo -e "16 - Masternode Sixteen"
  fi
  if [ -d /home/${COINl}17 ]; then
  echo -e "17 - Masternode Seventeen"
  fi
  if [ -d /home/${COINl}18 ]; then
  echo -e "18 - Masternode Eighteen"
  fi
  if [ -d /home/${COINl}19 ]; then
  echo -e "19 - Masternode Nineteen"
  fi
  if [ -d /home/${COINl}20 ]; then
  echo -e "20 - Masternode Twenty"
  fi
  if [ -d /home/${COINl}21 ]; then
  echo -e "21 - Masternode Twentyone"
  fi
  if [ -d /home/${COINl}22 ]; then
  echo -e "22 - Masternode Twentytwo"
  fi
  if [ -d /home/${COINl}23 ]; then
  echo -e "23 -  Masternode Twentythree"
  fi
  if [ -d /home/${COINl}24 ]; then
  echo -e "24 -  Masternode Twentyfour"
  fi
  if [ -d /home/${COINl}25 ]; then
  echo -e "25 -  Masternode Twentyfive"
  fi
  if [ -d /home/${COINl}26 ]; then
  echo -e "26 -  Masternode Twentysix"
  fi
  if [ -d /home/${COINl}27 ]; then
  echo -e "27 -  Masternode Twentyseven"
  fi
  if [ -d /home/${COINl}28 ]; then
  echo -e "28 -  Masternode Twentyeight"
  fi
  if [ -d /home/${COINl}29 ]; then
  echo -e "29 -  Masternode Twentynine"
  fi
  if [ -d /home/${COINl}30 ]; then
  echo -e "30 -  Masternode Thirty"
  fi
  if [ -d /home/${COINl}31 ]; then
  echo -e "31 -  Masternode Thirtyone"
  fi
  if [ -d /home/${COINl}32 ]; then
  echo -e "32 -  Masternode Thirtytwo"
  fi
  if [ -d /home/${COINl}33 ]; then
  echo -e "33 -  Masternode Thirtythree"
  fi
  if [ -d /home/${COINl}34 ]; then
  echo -e "34 -  Masternode Thirtyfour"
  fi
  if [ -d /home/${COINl}35 ]; then
  echo -e "35 -  Masternode Thirtyfive"
  fi
  if [ -d /home/${COINl}36 ]; then
  echo -e "36 -  Masternode Thirtysix"
  fi
  if [ -d /home/${COINl}37 ]; then
  echo -e "37 -  Masternode Thirtyseven"
  fi
  if [ -d /home/${COINl}38 ]; then
  echo -e "38 -  Masternode Thirtyeight"
  fi
  if [ -d /home/${COINl}39 ]; then
  echo -e "39 -  Masternode Thirtynine"
  fi
  if [ -d /home/${COINl}40 ]; then
  echo -e "40 -  Masternode Forty"
  fi
  if [ -d /home/${COINl}41 ]; then
  echo -e "41 -  Masternode Fortyone"
  fi
  if [ -d /home/${COINl}42 ]; then
  echo -e "42 -  Masternode Fortytwo"
  fi
  if [ -d /home/${COINl}43 ]; then
  echo -e "43 -  Masternode Fortythree"
  fi
  if [ -d /home/${COINl}44 ]; then
  echo -e "44 -  Masternode Fortyfour"
  fi
  if [ -d /home/${COINl}45 ]; then
  echo -e "45 -  Masternode Fortyfive"
  fi
  if [ -d /home/${COINl}46 ]; then
  echo -e "46 -  Masternode Fortysix"
  fi
  if [ -d /home/${COINl}47 ]; then
  echo -e "47 -  Masternode Fortyseven"
  fi
  if [ -d /home/${COINl}48 ]; then
  echo -e "48 -  Masternode Fortyeight"
  fi
  if [ -d /home/${COINl}49 ]; then
  echo -e "49 -  Masternode Fortynine"
  fi
  if [ -d /home/${COINl}50 ]; then
  echo -e "50 -  Masternode Fifty"
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
  13) nodeunit=13
  Function_ViewCat_masternode ;;
  14) nodeunit=14
  Function_ViewCat_masternode ;;
  15) nodeunit=15
  Function_ViewCat_masternode ;;
  16) nodeunit=16
  Function_ViewCat_masternode ;;
  17) nodeunit=17
  Function_ViewCat_masternode ;;
  18) nodeunit=18
  Function_ViewCat_masternode ;;
  19) nodeunit=19
  Function_ViewCat_masternode ;;
  20) nodeunit=20
  Function_ViewCat_masternode ;;
  21) nodeunit=21
  Function_ViewCat_masternode ;;
  22) nodeunit=22
  Function_ViewCat_masternode ;;
  23) nodeunit=23
  Function_ViewCat_masternode ;;
  24) nodeunit=24
  Function_ViewCat_masternode ;;
  25) nodeunit=25
  Function_ViewCat_masternode ;;
  26) nodeunit=26
  Function_ViewCat_masternode ;;
  27) nodeunit=27
  Function_ViewCat_masternode ;;
  28) nodeunit=28
  Function_ViewCat_masternode ;;
  29) nodeunit=29
  Function_ViewCat_masternode ;;
  30) nodeunit=30
  Function_ViewCat_masternode ;;
  31) nodeunit=31
  Function_ViewCat_masternode ;;
  32) nodeunit=32
  Function_ViewCat_masternode ;;
  33) nodeunit=33
  Function_ViewCat_masternode ;;
  34) nodeunit=34
  Function_ViewCat_masternode ;;
  35) nodeunit=35
  Function_ViewCat_masternode ;;
  36) nodeunit=36
  Function_ViewCat_masternode ;;
  37) nodeunit=37
  Function_ViewCat_masternode ;;
  38) nodeunit=38
  Function_ViewCat_masternode ;;
  39) nodeunit=39
  Function_ViewCat_masternode ;;
  40) nodeunit=40
  Function_ViewCat_masternode ;;
  41) nodeunit=41
  Function_ViewCat_masternode ;;
  42) nodeunit=42
  Function_ViewCat_masternode ;;
  43) nodeunit=43
  Function_ViewCat_masternode ;;
  44) nodeunit=44
  Function_ViewCat_masternode ;;
  45) nodeunit=45
  Function_ViewCat_masternode ;;
  46) nodeunit=46
  Function_ViewCat_masternode ;;
  47) nodeunit=47
  Function_ViewCat_masternode ;;
  48) nodeunit=48
  Function_ViewCat_masternode ;;
  49) nodeunit=49
  Function_ViewCat_masternode ;;
  50) nodeunit=50
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
  if [ -d /home/${COINl}13 ]; then
  echo -e "13 - Masternode Thirteen"
  fi
  if [ -d /home/${COINl}14 ]; then
  echo -e "14 - Masternode Fourteen"
  fi
  if [ -d /home/${COINl}15 ]; then
  echo -e "15 - Masternode Fifteen"
  fi
  if [ -d /home/${COINl}16 ]; then
  echo -e "16 - Masternode Sixteen"
  fi
  if [ -d /home/${COINl}17 ]; then
  echo -e "17 - Masternode Seventeen"
  fi
  if [ -d /home/${COINl}18 ]; then
  echo -e "18 - Masternode Eighteen"
  fi
  if [ -d /home/${COINl}19 ]; then
  echo -e "19 - Masternode Nineteen"
  fi
  if [ -d /home/${COINl}20 ]; then
  echo -e "20 - Masternode Twenty"
  fi
  if [ -d /home/${COINl}21 ]; then
  echo -e "21 - Masternode Twentyone"
  fi
  if [ -d /home/${COINl}22 ]; then
  echo -e "22 - Masternode Twentytwo"
  fi
  if [ -d /home/${COINl}23 ]; then
  echo -e "23 -  Masternode Twentythree"
  fi
  if [ -d /home/${COINl}24 ]; then
  echo -e "24 -  Masternode Twentyfour"
  fi
  if [ -d /home/${COINl}25 ]; then
  echo -e "25 -  Masternode Twentyfive"
  fi
  if [ -d /home/${COINl}26 ]; then
  echo -e "26 -  Masternode Twentysix"
  fi
  if [ -d /home/${COINl}27 ]; then
  echo -e "27 -  Masternode Twentyseven"
  fi
  if [ -d /home/${COINl}28 ]; then
  echo -e "28 -  Masternode Twentyeight"
  fi
  if [ -d /home/${COINl}29 ]; then
  echo -e "29 -  Masternode Twentynine"
  fi
  if [ -d /home/${COINl}30 ]; then
  echo -e "30 -  Masternode Thirty"
  fi
  if [ -d /home/${COINl}31 ]; then
  echo -e "31 -  Masternode Thirtyone"
  fi
  if [ -d /home/${COINl}32 ]; then
  echo -e "32 -  Masternode Thirtytwo"
  fi
  if [ -d /home/${COINl}33 ]; then
  echo -e "33 -  Masternode Thirtythree"
  fi
  if [ -d /home/${COINl}34 ]; then
  echo -e "34 -  Masternode Thirtyfour"
  fi
  if [ -d /home/${COINl}35 ]; then
  echo -e "35 -  Masternode Thirtyfive"
  fi
  if [ -d /home/${COINl}36 ]; then
  echo -e "36 -  Masternode Thirtysix"
  fi
  if [ -d /home/${COINl}37 ]; then
  echo -e "37 -  Masternode Thirtyseven"
  fi
  if [ -d /home/${COINl}38 ]; then
  echo -e "38 -  Masternode Thirtyeight"
  fi
  if [ -d /home/${COINl}39 ]; then
  echo -e "39 -  Masternode Thirtynine"
  fi
  if [ -d /home/${COINl}40 ]; then
  echo -e "40 -  Masternode Forty"
  fi
  if [ -d /home/${COINl}41 ]; then
  echo -e "41 -  Masternode Fortyone"
  fi
  if [ -d /home/${COINl}42 ]; then
  echo -e "42 -  Masternode Fortytwo"
  fi
  if [ -d /home/${COINl}43 ]; then
  echo -e "43 -  Masternode Fortythree"
  fi
  if [ -d /home/${COINl}44 ]; then
  echo -e "44 -  Masternode Fortyfour"
  fi
  if [ -d /home/${COINl}45 ]; then
  echo -e "45 -  Masternode Fortyfive"
  fi
  if [ -d /home/${COINl}46 ]; then
  echo -e "46 -  Masternode Fortysix"
  fi
  if [ -d /home/${COINl}47 ]; then
  echo -e "47 -  Masternode Fortyseven"
  fi
  if [ -d /home/${COINl}48 ]; then
  echo -e "48 -  Masternode Fortyeight"
  fi
  if [ -d /home/${COINl}49 ]; then
  echo -e "49 -  Masternode Fortynine"
  fi
  if [ -d /home/${COINl}50 ]; then
  echo -e "50 -  Masternode Fifty"
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
    13) nodeunit=13
    Function_Stop_Masternode ;;
    14) nodeunit=14
    Function_Stop_Masternode ;;
    15) nodeunit=15
    Function_Stop_Masternode ;;
    16) nodeunit=16
    Function_Stop_Masternode ;;
    17) nodeunit=17
    Function_Stop_Masternode ;;
    18) nodeunit=18
    Function_Stop_Masternode ;;
    19) nodeunit=19
    Function_Stop_Masternode ;;
    20) nodeunit=20
    Function_Stop_Masternode ;;
    21) nodeunit=21
    Function_Stop_Masternode ;;
    22) nodeunit=22
    Function_Stop_Masternode ;;
    23) nodeunit=23
    Function_Stop_Masternode ;;
    24) nodeunit=24
    Function_Stop_Masternode ;;
    25) nodeunit=25
    Function_Stop_Masternode ;;
    26) nodeunit=26
    Function_Stop_Masternode ;;
    27) nodeunit=27
    Function_Stop_Masternode ;;
    28) nodeunit=28
    Function_Stop_Masternode ;;
    29) nodeunit=29
    Function_Stop_Masternode ;;
    30) nodeunit=30
    Function_Stop_Masternode ;;
    31) nodeunit=31
    Function_Stop_Masternode ;;
    32) nodeunit=32
    Function_Stop_Masternode ;;
    33) nodeunit=33
    Function_Stop_Masternode ;;
    34) nodeunit=34
    Function_Stop_Masternode ;;
    35) nodeunit=35
    Function_Stop_Masternode ;;
    36) nodeunit=36
    Function_Stop_Masternode ;;
    37) nodeunit=37
    Function_Stop_Masternode ;;
    38) nodeunit=38
    Function_Stop_Masternode ;;
    39) nodeunit=39
    Function_Stop_Masternode ;;
    40) nodeunit=40
    Function_Stop_Masternode ;;
    41) nodeunit=41
    Function_Stop_Masternode ;;
    42) nodeunit=42
    Function_Stop_Masternode ;;
    43) nodeunit=43
    Function_Stop_Masternode ;;
    44) nodeunit=44
    Function_Stop_Masternode ;;
    45) nodeunit=45
    Function_Stop_Masternode ;;
    46) nodeunit=46
    Function_Stop_Masternode ;;
    47) nodeunit=47
    Function_Stop_Masternode ;;
    48) nodeunit=48
    Function_Stop_Masternode ;;
    49) nodeunit=49
    Function_Stop_Masternode ;;
    50) nodeunit=50
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
  until [[ $nodeunit = 51 ]]; do
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
    11) nodeunit=11
    edit_menu_choice ;;
    12) nodeunit=12
    edit_menu_choice ;;
    13) nodeunit=13
    edit_menu_choice ;;
    14) nodeunit=14
    edit_menu_choice ;;
    15) nodeunit=15
    edit_menu_choice ;;
    16) nodeunit=16
    edit_menu_choice ;;
    17) nodeunit=17
    edit_menu_choice ;;
    18) nodeunit=18
    edit_menu_choice ;;
    19) nodeunit=19
    edit_menu_choice ;;
    20) nodeunit=20
    edit_menu_choice ;;
    21) nodeunit=21
    edit_menu_choice ;;
    22) nodeunit=22
    edit_menu_choice ;;
    23) nodeunit=23
    edit_menu_choice ;;
    24) nodeunit=24
    edit_menu_choice ;;
    25) nodeunit=25
    edit_menu_choice ;;
    26) nodeunit=26
    edit_menu_choice ;;
    27) nodeunit=27
    edit_menu_choice ;;
    28) nodeunit=28
    edit_menu_choice ;;
    29) nodeunit=29
    edit_menu_choice ;;
    30) nodeunit=30
    edit_menu_choice ;;
    31) nodeunit=31
    edit_menu_choice ;;
    32) nodeunit=32
    edit_menu_choice ;;
    33) nodeunit=33
    edit_menu_choice ;;
    34) nodeunit=34
    edit_menu_choice ;;
    35) nodeunit=35
    edit_menu_choice ;;
    36) nodeunit=36
    edit_menu_choice ;;
    37) nodeunit=37
    edit_menu_choice ;;
    38) nodeunit=38
    edit_menu_choice ;;
    39) nodeunit=39
    edit_menu_choice ;;
    40) nodeunit=40
    edit_menu_choice ;;
    41) nodeunit=41
    edit_menu_choice ;;
    42) nodeunit=42
    edit_menu_choice ;;
    43) nodeunit=43
    edit_menu_choice ;;
    44) nodeunit=44
    edit_menu_choice ;;
    45) nodeunit=45
    edit_menu_choice ;;
    46) nodeunit=46
    edit_menu_choice ;;
    47) nodeunit=47
    edit_menu_choice ;;
    48) nodeunit=48
    edit_menu_choice ;;
    49) nodeunit=49
    edit_menu_choice ;;
    50) nodeunit=50
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
  echo -e "11 - Masternode Eleven"
  fi
  if [ -d /home/${COINl}12 ]; then
  echo -e "12 - Masternode Twelve"
  fi
  if [ -d /home/${COINl}13 ]; then
  echo -e "13 - Masternode Thirteen"
  fi
  if [ -d /home/${COINl}14 ]; then
  echo -e "14 - Masternode Fourteen"
  fi
  if [ -d /home/${COINl}15 ]; then
  echo -e "15 - Masternode Fifteen"
  fi
  if [ -d /home/${COINl}16 ]; then
  echo -e "16 - Masternode Sixteen"
  fi
  if [ -d /home/${COINl}17 ]; then
  echo -e "17 - Masternode Seventeen"
  fi
  if [ -d /home/${COINl}18 ]; then
  echo -e "18 - Masternode Eighteen"
  fi
  if [ -d /home/${COINl}19 ]; then
  echo -e "19 - Masternode Nineteen"
  fi
  if [ -d /home/${COINl}20 ]; then
  echo -e "20 - Masternode Twenty"
  fi
  if [ -d /home/${COINl}21 ]; then
  echo -e "21 - Masternode Twentyone"
  fi
  if [ -d /home/${COINl}22 ]; then
  echo -e "22 - Masternode Twentytwo"
  fi
  if [ -d /home/${COINl}23 ]; then
  echo -e "23 -  Masternode Twentythree"
  fi
  if [ -d /home/${COINl}24 ]; then
  echo -e "24 -  Masternode Twentyfour"
  fi
  if [ -d /home/${COINl}25 ]; then
  echo -e "25 -  Masternode Twentyfive"
  fi
  if [ -d /home/${COINl}26 ]; then
  echo -e "26 -  Masternode Twentysix"
  fi
  if [ -d /home/${COINl}27 ]; then
  echo -e "27 -  Masternode Twentyseven"
  fi
  if [ -d /home/${COINl}28 ]; then
  echo -e "28 -  Masternode Twentyeight"
  fi
  if [ -d /home/${COINl}29 ]; then
  echo -e "29 -  Masternode Twentynine"
  fi
  if [ -d /home/${COINl}30 ]; then
  echo -e "30 -  Masternode Thirty"
  fi
  if [ -d /home/${COINl}31 ]; then
  echo -e "31 -  Masternode Thirtyone"
  fi
  if [ -d /home/${COINl}32 ]; then
  echo -e "32 -  Masternode Thirtytwo"
  fi
  if [ -d /home/${COINl}33 ]; then
  echo -e "33 -  Masternode Thirtythree"
  fi
  if [ -d /home/${COINl}34 ]; then
  echo -e "34 -  Masternode Thirtyfour"
  fi
  if [ -d /home/${COINl}35 ]; then
  echo -e "35 -  Masternode Thirtyfive"
  fi
  if [ -d /home/${COINl}36 ]; then
  echo -e "36 -  Masternode Thirtysix"
  fi
  if [ -d /home/${COINl}37 ]; then
  echo -e "37 -  Masternode Thirtyseven"
  fi
  if [ -d /home/${COINl}38 ]; then
  echo -e "38 -  Masternode Thirtyeight"
  fi
  if [ -d /home/${COINl}39 ]; then
  echo -e "39 -  Masternode Thirtynine"
  fi
  if [ -d /home/${COINl}40 ]; then
  echo -e "40 -  Masternode Forty"
  fi
  if [ -d /home/${COINl}41 ]; then
  echo -e "41 -  Masternode Fortyone"
  fi
  if [ -d /home/${COINl}42 ]; then
  echo -e "42 -  Masternode Fortytwo"
  fi
  if [ -d /home/${COINl}43 ]; then
  echo -e "43 -  Masternode Fortythree"
  fi
  if [ -d /home/${COINl}44 ]; then
  echo -e "44 -  Masternode Fortyfour"
  fi
  if [ -d /home/${COINl}45 ]; then
  echo -e "45 -  Masternode Fortyfive"
  fi
  if [ -d /home/${COINl}46 ]; then
  echo -e "46 -  Masternode Fortysix"
  fi
  if [ -d /home/${COINl}47 ]; then
  echo -e "47 -  Masternode Fortyseven"
  fi
  if [ -d /home/${COINl}48 ]; then
  echo -e "48 -  Masternode Fortyeight"
  fi
  if [ -d /home/${COINl}49 ]; then
  echo -e "49 -  Masternode Fortynine"
  fi
  if [ -d /home/${COINl}50 ]; then
  echo -e "50 -  Masternode Fifty"
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
  disp_masternode_Version
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
    10) nodeunit=10
    display_MN_choice ;;
    11) nodeunit=11
    display_MN_choice ;;
    12) nodeunit=12
    display_MN_choice ;;
    13) nodeunit=13
    display_MN_choice ;;
    14) nodeunit=14
    display_MN_choice ;;
    15) nodeunit=15
    display_MN_choice ;;
    16) nodeunit=16
    display_MN_choice ;;
    17) nodeunit=17
    display_MN_choice ;;
    18) nodeunit=18
    display_MN_choice ;;
    19) nodeunit=19
    display_MN_choice ;;
    20) nodeunit=20
    display_MN_choice ;;
    21) nodeunit=21
    display_MN_choice ;;
    22) nodeunit=22
    display_MN_choice ;;
    23) nodeunit=23
    display_MN_choice ;;
    24) nodeunit=24
    display_MN_choice ;;
    25) nodeunit=25
    display_MN_choice ;;
    26) nodeunit=26
    display_MN_choice ;;
    27) nodeunit=27
    display_MN_choice ;;
    28) nodeunit=28
    display_MN_choice ;;
    29) nodeunit=29
    display_MN_choice ;;
    30) nodeunit=30
    display_MN_choice ;;
    31) nodeunit=31
    display_MN_choice ;;
    32) nodeunit=32
    display_MN_choice ;;
    33) nodeunit=33
    display_MN_choice ;;
    34) nodeunit=34
    display_MN_choice ;;
    35) nodeunit=35
    display_MN_choice ;;
    36) nodeunit=36
    display_MN_choice ;;
    37) nodeunit=37
    display_MN_choice ;;
    38) nodeunit=38
    display_MN_choice ;;
    39) nodeunit=39
    display_MN_choice ;;
    40) nodeunit=40
    display_MN_choice ;;
    41) nodeunit=41
    display_MN_choice ;;
    42) nodeunit=42
    display_MN_choice ;;
    43) nodeunit=43
    display_MN_choice ;;
    44) nodeunit=44
    display_MN_choice ;;
    45) nodeunit=45
    display_MN_choice ;;
    46) nodeunit=46
    display_MN_choice ;;
    47) nodeunit=47
    display_MN_choice ;;
    48) nodeunit=48
    display_MN_choice ;;
    49) nodeunit=49
    display_MN_choice ;;
    50) nodeunit=50
    display_MN_choice ;;
    0) nodeunit=0
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

  disp_masternode_Version(){
  echo -e ${GREEN}"Reporting Masternode Version" ${YELLOW}
  ${COINDAEMONCLI} -datadir=${COINHOME}${nodeunit}/${COINCORE} getinfo
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
    13) nodeunit=13
    Find_All_Masternodes ;;
    14) nodeunit=14
    Find_All_Masternodes ;;
    15) nodeunit=15
    Find_All_Masternodes ;;
    16) nodeunit=16
    Find_All_Masternodes ;;
    17) nodeunit=17
    Find_All_Masternodes ;;
    18) nodeunit=18
    Find_All_Masternodes ;;
    19) nodeunit=19
    Find_All_Masternodes ;;
    20) nodeunit=20
    Find_All_Masternodes ;;
    21) nodeunit=21
    Find_All_Masternodes ;;
    22) nodeunit=22
    Find_All_Masternodes ;;
    23) nodeunit=23
    Find_All_Masternodes ;;
    24) nodeunit=24
    Find_All_Masternodes ;;
    25) nodeunit=25
    Find_All_Masternodes ;;
    26) nodeunit=26
    Find_All_Masternodes ;;
    27) nodeunit=27
    Find_All_Masternodes ;;
    28) nodeunit=28
    Find_All_Masternodes ;;
    29) nodeunit=29
    Find_All_Masternodes ;;
    30) nodeunit=30
    Find_All_Masternodes ;;
    31) nodeunit=31
    Find_All_Masternodes ;;
    32) nodeunit=32
    Find_All_Masternodes ;;
    33) nodeunit=33
    Find_All_Masternodes ;;
    34) nodeunit=34
    Find_All_Masternodes ;;
    35) nodeunit=35
    Find_All_Masternodes ;;
    36) nodeunit=36
    Find_All_Masternodes ;;
    37) nodeunit=37
    Find_All_Masternodes ;;
    38) nodeunit=38
    Find_All_Masternodes ;;
    39) nodeunit=39
    Find_All_Masternodes ;;
    40) nodeunit=40
    Find_All_Masternodes ;;
    41) nodeunit=41
    Find_All_Masternodes ;;
    42) nodeunit=42
    Find_All_Masternodes ;;
    43) nodeunit=43
    Find_All_Masternodes ;;
    44) nodeunit=44
    Find_All_Masternodes ;;
    45) nodeunit=45
    Find_All_Masternodes ;;
    46) nodeunit=46
    Find_All_Masternodes ;;
    47) nodeunit=47
    Find_All_Masternodes ;;
    48) nodeunit=48
    Find_All_Masternodes ;;
    49) nodeunit=49
    Find_All_Masternodes ;;
    50) nodeunit=50
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
  until [[ $nodeunit = 52 ]]; do
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
          if [ ! -z "$DISPIP" ]; then
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
        if [[ $(lsb_release -d) != *18.04* ]]; then
          echo -e ${RED}"The operating system is not Ubuntu 18.04 You must be running on ubuntu 18.04"${CLEAR}
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
  sudo apt-get install libboost-filesystem1.65.1
  sudo apt-get -y install libdb4.8-dev
  sudo apt-get -y install libdb4.8++-dev
  sudo apt-get -y install libzmq3-dev
  sudo apt-get -y install libminiupnpc-dev
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
        echo -e "Welcome to GenesisX 30 in 1 Masternode Script"
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
    elif [[ $nodeunit -eq 13 ]] ; then
      echo "externalip=[${MNIP13}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 14 ]] ; then
      echo "externalip=[${MNIP14}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 15 ]] ; then
      echo "externalip=[${MNIP15}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 16 ]] ; then
      echo "externalip=[${MNIP16}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 17 ]] ; then
      echo "externalip=[${MNIP17}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 18 ]] ; then
      echo "externalip=[${MNIP18}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 19 ]] ; then
      echo "externalip=[${MNIP19}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 20 ]] ; then
      echo "externalip=[${MNIP20}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 21 ]] ; then
      echo "externalip=[${MNIP21}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 22 ]] ; then
      echo "externalip=[${MNIP22}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 23 ]] ; then
      echo "externalip=[${MNIP23}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 24 ]] ; then
      echo "externalip=[${MNIP24}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 25 ]] ; then
      echo "externalip=[${MNIP25}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 26 ]] ; then
      echo "externalip=[${MNIP26}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 27 ]] ; then
      echo "externalip=[${MNIP27}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 28 ]] ; then
      echo "externalip=[${MNIP28}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 29 ]] ; then
      echo "externalip=[${MNIP29}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 30 ]] ; then
      echo "externalip=[${MNIP30}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 31 ]] ; then
      echo "externalip=[${MNIP31}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 32 ]] ; then
      echo "externalip=[${MNIP32}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 33 ]] ; then
      echo "externalip=[${MNIP33}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 34 ]] ; then
      echo "externalip=[${MNIP34}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 35 ]] ; then
      echo "externalip=[${MNIP35}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 36 ]] ; then
      echo "externalip=[${MNIP36}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 37 ]] ; then
      echo "externalip=[${MNIP37}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 38 ]] ; then
      echo "externalip=[${MNIP38}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 39 ]] ; then
      echo "externalip=[${MNIP39}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 40 ]] ; then
      echo "externalip=[${MNIP40}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 41 ]] ; then
      echo "externalip=[${MNIP41}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 42 ]] ; then
      echo "externalip=[${MNIP42}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 43 ]] ; then
      echo "externalip=[${MNIP43}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 44 ]] ; then
      echo "externalip=[${MNIP44}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 45 ]] ; then
      echo "externalip=[${MNIP45}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 46 ]] ; then
      echo "externalip=[${MNIP46}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 47 ]] ; then
      echo "externalip=[${MNIP47}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 48 ]] ; then
      echo "externalip=[${MNIP48}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 49 ]] ; then
      echo "externalip=[${MNIP49}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 50 ]] ; then
      echo "externalip=[${MNIP50}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
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
  elif [[ $nodeunit -eq 13 ]] ; then
  echo "masternodeprivkey=$PRIVK13" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 14 ]] ; then
  echo "masternodeprivkey=$PRIVK14" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 15 ]] ; then
  echo "masternodeprivkey=$PRIVK15" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 16 ]] ; then
  echo "masternodeprivkey=$PRIVK16" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 17 ]] ; then
  echo "masternodeprivkey=$PRIVK17" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 18 ]] ; then
  echo "masternodeprivkey=$PRIVK18" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 19 ]] ; then
  echo "masternodeprivkey=$PRIVK19" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 20 ]] ; then
  echo "masternodeprivkey=$PRIVK20" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 21 ]] ; then
  echo "masternodeprivkey=$PRIVK21" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 22 ]] ; then
  echo "masternodeprivkey=$PRIVK22" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 23 ]] ; then
  echo "masternodeprivkey=$PRIVK23" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 24 ]] ; then
  echo "masternodeprivkey=$PRIVK24" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 25 ]] ; then
  echo "masternodeprivkey=$PRIVK25" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 26 ]] ; then
  echo "masternodeprivkey=$PRIVK26" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 27 ]] ; then
  echo "masternodeprivkey=$PRIVK27" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 28 ]] ; then
  echo "masternodeprivkey=$PRIVK28" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 29 ]] ; then
  echo "masternodeprivkey=$PRIVK29" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 30 ]] ; then
  echo "masternodeprivkey=$PRIVK30" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 31 ]] ; then
  echo "masternodeprivkey=$PRIVK31" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 32 ]] ; then
  echo "masternodeprivkey=$PRIVK32" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 33 ]] ; then
  echo "masternodeprivkey=$PRIVK33" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 34 ]] ; then
  echo "masternodeprivkey=$PRIVK34" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 35 ]] ; then
  echo "masternodeprivkey=$PRIVK35" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 36 ]] ; then
  echo "masternodeprivkey=$PRIVK36" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 37 ]] ; then
  echo "masternodeprivkey=$PRIVK37" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 38 ]] ; then
  echo "masternodeprivkey=$PRIVK38" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 39 ]] ; then
  echo "masternodeprivkey=$PRIVK39" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 40 ]] ; then
  echo "masternodeprivkey=$PRIVK40" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 41 ]] ; then
  echo "masternodeprivkey=$PRIVK41" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 42 ]] ; then
  echo "masternodeprivkey=$PRIVK42" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 43 ]] ; then
  echo "masternodeprivkey=$PRIVK43" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 44 ]] ; then
  echo "masternodeprivkey=$PRIVK44" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 45 ]] ; then
  echo "masternodeprivkey=$PRIVK45" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 46 ]] ; then
  echo "masternodeprivkey=$PRIVK46" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 47 ]] ; then
  echo "masternodeprivkey=$PRIVK47" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 48 ]] ; then
  echo "masternodeprivkey=$PRIVK48" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 49 ]] ; then
  echo "masternodeprivkey=$PRIVK49" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  elif [[ $nodeunit -eq 50 ]] ; then
  echo "masternodeprivkey=$PRIVK50" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
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
  echo "addnode=$ADDNODE13" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE14" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE15" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE16" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE17" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE18" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE19" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE20" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE21" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE22" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE23" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE24" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE25" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE26" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE27" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE28" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE29" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE30" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE31" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE32" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE33" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE34" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE35" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE36" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE37" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE38" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE39" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE40" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE41" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE42" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE43" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE44" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE45" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE46" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE47" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE48" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE49" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE50" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
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
  sleep 3
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
    echo -e "2  - Two Masternodes"
    echo -e "3  - Three Masternodes"
    echo -e "4  - Four Masternodes"
    echo -e "5  - Five Masternodes"
    echo -e "6  - Six Masternodes"
    echo -e "7  - Seven Masternodes"
    echo -e "8  - Eight Masternodes"
    echo -e "9  - Nine Masternodes"
    echo -e "10  - Ten Masternodes"
    echo -e "11  - Eleven Masternodes"
    echo -e "12  - Twelve Masternodes"
    echo -e "13  - Thirteen Masternodes"
    echo -e "14  - Fourteen Masternodes"
    echo -e "15  - Fifteen Masternodes"
    echo -e "16  - Sixteen Masternodes"
    echo -e "17  - Seventeen Masternodes"
    echo -e "18  - Eighteen Masternodes"
    echo -e "19  - Nineteen Masternodes"
    echo -e "20  - Twenty Masternodes"
    echo -e "21  - Twentyone Masternodes"
    echo -e "22  - Twentytwo Masternodes"
    echo -e "23  - Twentythree Masternodes"
    echo -e "24  - Twentyfour Masternodes"
    echo -e "25  - Twentyfive Masternodes"
    echo -e "26  - Twentysix Masternodes"
    echo -e "27  - Twentyseven Masternodes"
    echo -e "28  - Twentyeight Masternodes"
    echo -e "29  - Twentynine Masternodes"
    echo -e "30  - Thirty Masternodes"
    echo -e "31  - Thirtyone Masternodes"
    echo -e "32  - Thirtytwo Masternodes"
    echo -e "33  - Thirtythree Masternodes"
    echo -e "34  - Thirtyfour Masternodes"
    echo -e "35  - Thirtyfive Masternodes"
    echo -e "36  - Thirtysix Masternodes"
    echo -e "37  - Thirtyseven Masternodes"
    echo -e "38  - Thirtyeight Masternodes"
    echo -e "39  - Thirtynine Masternodes"
    echo -e "40  - Forty Masternodes"
    echo -e "41  - Fortyone Masternodes"
    echo -e "42  - Fortytwo Masternodes"
    echo -e "43  - Fortythree Masternodes"
    echo -e "44  - Fortyfour Masternodes"
    echo -e "45  - Fortyfive Masternodes"
    echo -e "46  - Fortysix Masternodes"
    echo -e "47  - Fortyseven Masternodes"
    echo -e "48  - Fortyeight Masternodes"
    echo -e "49  - Fortynine Masternodes"
    echo -e "50  - Fifty Masternodes"
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
      13)INSTALLAMOUNT=13
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      14)INSTALLAMOUNT=14
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      15)INSTALLAMOUNT=15
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      16)INSTALLAMOUNT=16
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      17)INSTALLAMOUNT=17
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      18)INSTALLAMOUNT=18
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      19)INSTALLAMOUNT=19
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      20)INSTALLAMOUNT=20
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      21)INSTALLAMOUNT=21
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      22)INSTALLAMOUNT=22
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      23) INSTALLAMOUNT=23
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      24)INSTALLAMOUNT=24
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      25)INSTALLAMOUNT=25
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      26)INSTALLAMOUNT=26
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      27)INSTALLAMOUNT=27
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      28)INSTALLAMOUNT=28
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      29)INSTALLAMOUNT=29
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      30)INSTALLAMOUNT=30
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      31)INSTALLAMOUNT=31
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      32)INSTALLAMOUNT=32
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      33)INSTALLAMOUNT=33
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      34)INSTALLAMOUNT=34
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      35)INSTALLAMOUNT=35
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      36)INSTALLAMOUNT=36
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      37)INSTALLAMOUNT=37
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      38)INSTALLAMOUNT=38
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      39)INSTALLAMOUNT=39
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      40)INSTALLAMOUNT=40
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      41)INSTALLAMOUNT=41
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      42)INSTALLAMOUNT=42
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      43)INSTALLAMOUNT=43
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      44)INSTALLAMOUNT=44
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      45)INSTALLAMOUNT=45
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      46)INSTALLAMOUNT=46
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      47)INSTALLAMOUNT=47
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      48)INSTALLAMOUNT=48
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      49)INSTALLAMOUNT=49
      Function_Install_Secondaries
      Function_Display_MasternodeConf ;;
      50)INSTALLAMOUNT=50
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
    bash <(curl -Ls https://raw.githubusercontent.com/CowsGoWuff/GenesisX30MN/master/donations.sh)
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
  echo -e ${GREEN}"IP for Masternode 11"${CLEAR}
  read MNIP11
  echo -e ${GREEN}"IP for Masternode 12"${CLEAR}
  read MNIP12
  echo -e ${GREEN}"IP for Masternode 13"${CLEAR}
  read MNIP13
  echo -e ${GREEN}"IP for Masternode 14"${CLEAR}
  read MNIP14
  echo -e ${GREEN}"IP for Masternode 15"${CLEAR}
  read MNIP15
  echo -e ${GREEN}"IP for Masternode 16"${CLEAR}
  read MNIP16
  echo -e ${GREEN}"IP for Masternode 17"${CLEAR}
  read MNIP17
  echo -e ${GREEN}"IP for Masternode 18"${CLEAR}
  read MNIP18
  echo -e ${GREEN}"IP for Masternode 19"${CLEAR}
  read MNIP19
  echo -e ${GREEN}"IP for Masternode 20"${CLEAR}
  read MNIP20
  echo -e ${GREEN}"IP for Masternode 21"${CLEAR}
  read MNIP21
  echo -e ${GREEN}"IP for Masternode 22"${CLEAR}
  read MNIP22
  echo -e ${GREEN}"IP for Masternode 23"${CLEAR}
  read MNIP23
  echo -e ${GREEN}"IP for Masternode 24"${CLEAR}
  read MNIP24
  echo -e ${GREEN}"IP for Masternode 25"${CLEAR}
  read MNIP25
  echo -e ${GREEN}"IP for Masternode 26"${CLEAR}
  read MNIP26
  echo -e ${GREEN}"IP for Masternode 27"${CLEAR}
  read MNIP27
  echo -e ${GREEN}"IP for Masternode 28"${CLEAR}
  read MNIP28
  echo -e ${GREEN}"IP for Masternode 29"${CLEAR}
  read MNIP29
  echo -e ${GREEN}"IP for Masternode 30"${CLEAR}
  read MNIP30
  echo -e ${GREEN}"IP for Masternode 31"${CLEAR}
  read MNIP31
  echo -e ${GREEN}"IP for Masternode 32"${CLEAR}
  read MNIP32
  echo -e ${GREEN}"IP for Masternode 33"${CLEAR}
  read MNIP33
  echo -e ${GREEN}"IP for Masternode 34"${CLEAR}
  read MNIP34
  echo -e ${GREEN}"IP for Masternode 35"${CLEAR}
  read MNIP35
  echo -e ${GREEN}"IP for Masternode 36"${CLEAR}
  read MNIP36
  echo -e ${GREEN}"IP for Masternode 37"${CLEAR}
  read MNIP37
  echo -e ${GREEN}"IP for Masternode 38"${CLEAR}
  read MNIP38
  echo -e ${GREEN}"IP for Masternode 39"${CLEAR}
  read MNIP39
  echo -e ${GREEN}"IP for Masternode 40"${CLEAR}
  read MNIP40
  echo -e ${GREEN}"IP for Masternode 41"${CLEAR}
  read MNIP41
  echo -e ${GREEN}"IP for Masternode 42"${CLEAR}
  read MNIP42
  echo -e ${GREEN}"IP for Masternode 43"${CLEAR}
  read MNIP43
  echo -e ${GREEN}"IP for Masternode 44"${CLEAR}
  read MNIP44
  echo -e ${GREEN}"IP for Masternode 45"${CLEAR}
  read MNIP45
  echo -e ${GREEN}"IP for Masternode 46"${CLEAR}
  read MNIP46
  echo -e ${GREEN}"IP for Masternode 47"${CLEAR}
  read MNIP47
  echo -e ${GREEN}"IP for Masternode 48"${CLEAR}
  read MNIP48
  echo -e ${GREEN}"IP for Masternode 49"${CLEAR}
  read MNIP49
  echo -e ${GREEN}"IP for Masternode 50"${CLEAR}
  read MNIP50

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
  for i in {15362..15426}; do printf "${IP}:%.4x\n" $i >> ${DPATH}ip.tbl; done
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
  MNIP13=$(sed -n '16p' < ${DPATH}ip.tbl)
  MNIP14=$(sed -n '17p' < ${DPATH}ip.tbl)
  MNIP15=$(sed -n '18p' < ${DPATH}ip.tbl)
  MNIP16=$(sed -n '19p' < ${DPATH}ip.tbl)
  MNIP17=$(sed -n '20p' < ${DPATH}ip.tbl)
  MNIP18=$(sed -n '21p' < ${DPATH}ip.tbl)
  MNIP19=$(sed -n '22p' < ${DPATH}ip.tbl)
  MNIP20=$(sed -n '23p' < ${DPATH}ip.tbl)
  MNIP21=$(sed -n '24p' < ${DPATH}ip.tbl)
  MNIP22=$(sed -n '25p' < ${DPATH}ip.tbl)
  MNIP23=$(sed -n '26p' < ${DPATH}ip.tbl)
  MNIP24=$(sed -n '27p' < ${DPATH}ip.tbl)
  MNIP25=$(sed -n '28p' < ${DPATH}ip.tbl)
  MNIP26=$(sed -n '29p' < ${DPATH}ip.tbl)
  MNIP27=$(sed -n '30p' < ${DPATH}ip.tbl)
  MNIP28=$(sed -n '31p' < ${DPATH}ip.tbl)
  MNIP29=$(sed -n '32p' < ${DPATH}ip.tbl)
  MNIP30=$(sed -n '33p' < ${DPATH}ip.tbl)
  MNIP31=$(sed -n '34p' < ${DPATH}ip.tbl)
  MNIP32=$(sed -n '35p' < ${DPATH}ip.tbl)
  MNIP33=$(sed -n '36p' < ${DPATH}ip.tbl)
  MNIP34=$(sed -n '37p' < ${DPATH}ip.tbl)
  MNIP35=$(sed -n '38p' < ${DPATH}ip.tbl)
  MNIP36=$(sed -n '39p' < ${DPATH}ip.tbl)
  MNIP37=$(sed -n '40p' < ${DPATH}ip.tbl)
  MNIP38=$(sed -n '41p' < ${DPATH}ip.tbl)
  MNIP39=$(sed -n '42p' < ${DPATH}ip.tbl)
  MNIP40=$(sed -n '43p' < ${DPATH}ip.tbl)
  MNIP41=$(sed -n '44p' < ${DPATH}ip.tbl)
  MNIP42=$(sed -n '45p' < ${DPATH}ip.tbl)
  MNIP43=$(sed -n '46p' < ${DPATH}ip.tbl)
  MNIP44=$(sed -n '47p' < ${DPATH}ip.tbl)
  MNIP45=$(sed -n '48p' < ${DPATH}ip.tbl)
  MNIP46=$(sed -n '49p' < ${DPATH}ip.tbl)
  MNIP47=$(sed -n '50p' < ${DPATH}ip.tbl)
  MNIP48=$(sed -n '51p' < ${DPATH}ip.tbl)
  MNIP49=$(sed -n '52p' < ${DPATH}ip.tbl)
  MNIP50=$(sed -n '53p' < ${DPATH}ip.tbl)

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
    until [[ $count = 30 ]]; do
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
    PRIVK13=$(sed -n '16p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK14=$(sed -n '17p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK15=$(sed -n '18p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK16=$(sed -n '19p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK17=$(sed -n '20p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK18=$(sed -n '21p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK19=$(sed -n '22p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK20=$(sed -n '23p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK21=$(sed -n '24p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK22=$(sed -n '25p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK23=$(sed -n '26p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK24=$(sed -n '27p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK25=$(sed -n '28p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK26=$(sed -n '29p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK27=$(sed -n '30p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK28=$(sed -n '31p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK29=$(sed -n '32p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK30=$(sed -n '33p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK31=$(sed -n '34p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK32=$(sed -n '35p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK33=$(sed -n '36p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK34=$(sed -n '37p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK35=$(sed -n '38p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK36=$(sed -n '39p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK37=$(sed -n '40p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK38=$(sed -n '41p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK39=$(sed -n '42p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK40=$(sed -n '43p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK41=$(sed -n '44p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK42=$(sed -n '45p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK43=$(sed -n '46p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK44=$(sed -n '47p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK45=$(sed -n '48p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK46=$(sed -n '49p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK47=$(sed -n '50p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK48=$(sed -n '51p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK49=$(sed -n '52p' < ${DPATH}${COIN3l}mnkey.tbl)
    PRIVK50=$(sed -n '53p' < ${DPATH}${COIN3l}mnkey.tbl)

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
    if [ -f /home/${COINl}13/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}13 [${MNIP13}]:$COINPORT $PRIVK13 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}14/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}14 [${MNIP14}]:$COINPORT $PRIVK14 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}15/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}15 [${MNIP15}]:$COINPORT $PRIVK15 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}16/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}16 [${MNIP16}]:$COINPORT $PRIVK16 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}17/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}17 [${MNIP17}]:$COINPORT $PRIVK17 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}18/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}18 [${MNIP18}]:$COINPORT $PRIVK18 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}19/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}19 [${MNIP19}]:$COINPORT $PRIVK19 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}20/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}20 [${MNIP20}]:$COINPORT $PRIVK20 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}21/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}21 [${MNIP21}]:$COINPORT $PRIVK21 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}22/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}22 [${MNIP22}]:$COINPORT $PRIVK22 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}23/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}23 [${MNIP23}]:$COINPORT $PRIVK23 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}24/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}24 [${MNIP24}]:$COINPORT $PRIVK24 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}25/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}25 [${MNIP25}]:$COINPORT $PRIVK25 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}26/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}26 [${MNIP26}]:$COINPORT $PRIVK26 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}27/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}27 [${MNIP27}]:$COINPORT $PRIVK27 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}28/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}28 [${MNIP28}]:$COINPORT $PRIVK28 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}29/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}29 [${MNIP29}]:$COINPORT $PRIVK29 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}30/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}30 [${MNIP30}]:$COINPORT $PRIVK30 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}31/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}31 [${MNIP31}]:$COINPORT $PRIVK31 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}32/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}32 [${MNIP32}]:$COINPORT $PRIVK32 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}33/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}33 [${MNIP33}]:$COINPORT $PRIVK33 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}34/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}34 [${MNIP34}]:$COINPORT $PRIVK34 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}35/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}35 [${MNIP35}]:$COINPORT $PRIVK35 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}36/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}36 [${MNIP36}]:$COINPORT $PRIVK36 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}37/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}37 [${MNIP37}]:$COINPORT $PRIVK37 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}38/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}38 [${MNIP38}]:$COINPORT $PRIVK38 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}39/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}39 [${MNIP39}]:$COINPORT $PRIVK39 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}40/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}40 [${MNIP40}]:$COINPORT $PRIVK40 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}41/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}41 [${MNIP41}]:$COINPORT $PRIVK41 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}42/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}42 [${MNIP42}]:$COINPORT $PRIVK42 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}43/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}43 [${MNIP43}]:$COINPORT $PRIVK43 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}44/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}44 [${MNIP44}]:$COINPORT $PRIVK44 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}45/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}45 [${MNIP45}]:$COINPORT $PRIVK45 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}46/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}46 [${MNIP46}]:$COINPORT $PRIVK46 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}47/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}47 [${MNIP47}]:$COINPORT $PRIVK47 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}48/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}48 [${MNIP48}]:$COINPORT $PRIVK48 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}49/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}49 [${MNIP49}]:$COINPORT $PRIVK49 [Transaction ID] [Transaction Output]"
    fi
    if [ -f /home/${COINl}50/.${COINl}/${COINCONFIG} ]; then
      echo -e "${COIN3l}50 [${MNIP50}]:$COINPORT $PRIVK50 [Transaction ID] [Transaction Output]"
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
