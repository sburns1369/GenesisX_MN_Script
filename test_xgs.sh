#!/bin/bash
COIN=genesisX
COINPORT=5555
COINRPCPORT=19012
COINDAEMON=genesisd
COINDAEMONCLI=genesis-cli
COINDAEMONTX=genesis-tx
COINCORE=.genesis
COINCONFIG=genesis.conf

#Setting Colors
BLUE='\033[0;96m'
GREEN='\033[0;92m'
RED='\033[0;91m'
YELLOW='\093[0;93m'
#clear font
CLEAR='\033[0m'

#Checking OS
if [[ $(lsb_release -d) != *16.04* ]]; then
  echo -e ${RED}"The operating system is not Ubuntu 16.04. You must be running on ubuntu 16.04."${CLEAR}
  exit 1
fi
#Menu to Confirm and Pull correct script
echo -e ${YELLOW}"Welcome to the NullDev Beta Automated Install Script"${CLEAR}
echo -e ${YELLOW}'THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND'${CLEAR}
echo -e ${YELLOW}"Durring this Process Please Hit Enter or Input What is Asked."${CLEAR}
echo
echo -e ${GREEN}"Are you sure you want to install exdex Masternode? type y/n followed by [ENTER]:"$${CLEAR}
read AGREE
if [[ $AGREE =~ "y" ]] ; then
echo -e ${GREEN}"Please enter the number of $COIN Masternode(s) you would like to install :"${NC}
read NUMBER
  if [[$NUMBER = "1"]] ; then
    echo - "Send Script one!"
  if [[$NUMBER = "2"]] ; then
    echo - "Send Script two!"
  if [[$NUMBER = "3"]] ; then
    echo - "Send Script three!"
  if [[$NUMBER = "4"]] ; then
    echo - "Send Script four!"
fi
