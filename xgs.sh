#!/bin/bash
#Setting Colors
BLUE='\033[0;96m'
GREEN='\033[0;92m'
RED='\033[0;91m'
YELLOW='\033[0;93m'
#clear font
CLEAR='\033[0m'
#Checking OS
if [[ $(lsb_release -d) != *16.04* ]]; then
  echo -e ${RED}"The operating system is not Ubuntu 16.04. You must be running on ubuntu 16.04."${CLEAR}
  exit 1
fi
#Menu to Confirm and Pull correct script
echo
echo
echo -e ${BLUE}
echo " _ __       _  _  __                                      ";
echo "' )  )     // // /  \`     _/_                            ";
echo " /  / . . // // /--  ____  /  __  __  ,                   ";
echo "/  (_(_/_</_</_(___,/ / <_<__/ (_/ (_/_                   ";
echo "                                    /                     ";
echo "                                   '                      ";
echo "     _ _ _                                                ";
echo "    ' ) ) )         _/_                   /               ";
echo "     / / / __.  _   /  _  __  ____  __ __/ _              ";
echo "    / ' (_(_/|_/_)_<__</_/ (_/ / <_(_)(_/_</_             ";
echo "                                                          ";
echo "                                                          ";
echo "             _                      _  _                  ";
echo "            | )           _/_      // //     _/_          ";
echo "        ,---|/  ____  _   /  __.  // // __.  /  o __ ____ ";
echo "         \_/ \_/ / <_/_)_<__(_/|_</_</_(_/|_<__<_(_)/ / <_";
echo
echo
echo -e ${YELLOW}"Welcome to the GenesisX Beta Automated Install Script by ${BLUE}NullEntry"${CLEAR}
echo -e ${RED}'THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND'${CLEAR}
echo
echo -e ${GREEN}"Are you sure you want to install GenesisX Masternode(s)?"${CLEAR}
echo -e ${GREEN} "Press y for yes and [ENTER]:"${CLEAR}
read AGREE
if [[ $AGREE =~ "y" ]] ; then
echo -e ${YELLOW}"IPv6 support is required for 2 or more Masternodes"${CLEAR}
echo -e ${YELLOW}"Vultr Users - Check Support IPv6 on initial Server Selection"${CLEAR}
echo
echo -e ${GREEN}"Please enter the number (1-8) of GenesisX Masternode(s)"${CLEAR}
echo -e ${YELLOW}" -If your VPS doesn't support IPv6 press 0 for 1 IPv4"${CLEAR}
echo -e ${GREEN}"you would like to install :"${CLEAR}
read NUMBER
case $NUMBER in
  0)bash <(curl -Ls https://raw.githubusercontent.com/sburns1369/GenesisX_MN_Script/master/GenesisX_singleV4.sh);;
  1)bash <(curl -Ls https://raw.githubusercontent.com/sburns1369/GenesisX_MN_Script/master/GenesisX_singleV6.sh);;
  2)bash <(curl -Ls https://raw.githubusercontent.com/sburns1369/GenesisX_MN_Script/master/GenesisX_2pack.sh);;
  3)bash <(curl -Ls https://raw.githubusercontent.com/sburns1369/GenesisX_MN_Script/master/GenesisX_3pack.sh);;
  4)bash <(curl -Ls https://raw.githubusercontent.com/sburns1369/GenesisX_MN_Script/master/GenesisX_4pack.sh);;
  5)bash <(curl -Ls https://raw.githubusercontent.com/sburns1369/GenesisX_MN_Script/master/GenesisX_5pack.sh);;
  6)bash <(curl -Ls https://raw.githubusercontent.com/sburns1369/GenesisX_MN_Script/master/GenesisX_6pack.sh);;
  7)bash <(curl -Ls https://raw.githubusercontent.com/sburns1369/GenesisX_MN_Script/master/GenesisX_7pack.sh);;
  8)bash <(curl -Ls https://raw.githubusercontent.com/sburns1369/GenesisX_MN_Script/master/GenesisX_8pack.sh);;
#  u)bash <(curl -Ls https://raw.githubusercontent.com/sburns1369/${COIN}_MN_Script/master/update_${COIN3l}.sh);;
  *)echo -e ${RED}"Invalid Option - Exiting Setup - Re-run to try again"${CLEAR};;
esac
fi
