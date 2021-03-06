#!/bin/bash
SCRIPTVERSION=0.7c
COIN=GenesisX
COINl=genesisx
COIN3=XGS
COIN3l=xgs
COINPORT=5555
COINRPCPORT1=19012
COINRPCPORT2=19013
COINRPCPORT3=19014
COINDAEMON=genesisxd
COINDAEMONCLI=genesisx-cli
COINCORE=.genesisx
COINCONFIG=genesisx.conf
COINVERSION=1.4.0
#AGREE = Agree to install Masternode
#NULLREC = Agree to Record nullentrydev information
#Setting Colors
BLUE='\033[0;36m'
GREEN='\033[0;92m'
RED='\033[0;91m'
YELLOW='\033[0;93m'
BOLD='\033[1;31m'
CLEAR='\033[0m'

#Checking OS - double check incase script ran directly
if [[ $(lsb_release -d) != *16.04* ]]; then
  echo -e ${RED}"The operating system is not Ubuntu 16.04. You must be running on ubuntu 16.04."${CLEAR}
  exit 1
fi
echo
echo
echo -e ${GREEN}"Are you sure you want to continue installation of Three ${COIN} Masternodes?"
echo -e "type y/n followed by [ENTER]:"${CLEAR}
read AGREE
if [[ $AGREE =~ "y" ]] ; then
echo
echo
echo
echo
# Permission to Store/Make nullentrydev files ####
echo -e ${BLUE}"May this script will store a small amount data in /usr/local/nullentrydev/ ?"${CLEAR}
echo -e ${BLUE}"This information is for version updates and later implimentation"${CLEAR}
echo -e ${BLUE}"Zero Confidental information or Wallet keys will be stored in it"${CLEAR}
echo -e ${YELLOW}"Press y to agree followed by [ENTER], or just [ENTER] to disagree"${CLEAR}
read NULLREC
echo
echo
echo
echo
echo
echo -e ${RED}"Your Masternode Private Keys are needed,"${CLEAR}
echo -e ${GREEN}" -which can be generated from the local wallet"${CLEAR}
echo
echo -e ${YELLOW}"You can edit the config later if you don't have this"${CLEAR}
echo -e ${YELLOW}"Masternode may fail to start with invalid key"${CLEAR}
echo
echo -e ${YELLOW}"Right Click to paste in some SSH Clients"${CLEAR}
echo
echo -e ${GREEN}"Please Enter Your First Masternode Private Key:"${CLEAR}
read privkey
echo
echo -e ${GREEN}"Please Enter Your Second Masternode Private Key:"${CLEAR}
read privkey2
echo
echo -e ${GREEN}"Please Enter Your Third Masternode Private Key:"${CLEAR}
read privkey3
echo
echo
echo "Creating 3 ${COIN} system users with no-login access:"
sudo adduser --system --home /home/${COINl} ${COINl}
sudo adduser --system --home /home/${COINl}2 ${COINl}2
sudo adduser --system --home /home/${COINl}3 ${COINl}3
# Checking For nullentrydev install information
cd ~
if [[ $NULLREC = "y" ]] ; then
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
fi
echo ${RED}"Updating Apps"${CLEAR}
sudo apt-get -y update
sudo apt-get -y upgrade
# Checking to see if Dependencies & Software Libraries have been installed
if grep -Fxq "dependenciesInstalled: true" /usr/local/nullentrydev/mnodes.log
then
    echo -e ${RED}"Skipping... Dependencies & Software Libraries - Previously installed"${CLEAR}
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
      echo "dependenciesInstalled: true" >> /usr/local/nullentrydev/mnodes.log
    fi
  fi
cd /var
sudo touch swap.img
sudo chmod 600 swap.img
echo -e ${YELLOW} "You should check out https://www.youtube.com/watch?v=lMDOGbYOS6E"${CLEAR}
sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=4096
sudo mkswap /var/swap.img
sudo swapon /var/swap.img
cd ~
if [ ! -d /root/${COIN3l} ]; then
  sudo mkdir /root/${COIN3l}
fi
cd /root/${COIN3l}
echo "Downloading latest ${COIN} binaries"
wget https://github.com/genesis-x/genesis-x/files/2799605/genesisx-linux.zip
unzip genesisx-linux.zip
sleep 3
sudo mv /root/${COIN3l}/${COINDAEMON} /root/${COIN3l}/${COINDAEMONCLI} /usr/local/bin
sudo chmod 755 -R  /usr/local/bin/${COINl}*
rm -rf /root/${COIN3l}
# First Node Configuration and launch
echo -e "${GREEN}Configuring First Node${CLEAR}"
sudo mkdir /home/${COINl}/.${COINl}
sudo touch /home/${COINl}/.${COINl}/${COINCONFIG}
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/${COINl}/.${COINl}/${COINCONFIG}
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/${COINl}/.${COINl}/${COINCONFIG}
echo "rpcallowip=127.0.0.1" >> /home/${COINl}/.${COINl}/${COINCONFIG}
echo "server=1" >> /home/${COINl}/.${COINl}/${COINCONFIG}
echo "daemon=1" >> /home/${COINl}/.${COINl}/${COINCONFIG}
echo "maxconnections=250" >> /home/${COINl}/.${COINl}/${COINCONFIG}
echo "masternode=1" >> /home/${COINl}/.${COINl}/${COINCONFIG}
echo "rpcport=$COINPORT" >> /home/${COINl}/.${COINl}/${COINCONFIG}
echo "listen=0" >> /home/${COINl}/.${COINl}/${COINCONFIG}
echo "externalip=$(hostname  -I | cut -f1 -d' '):$COINPORT" >> /home/${COINl}/.${COINl}/${COINCONFIG}
echo "masternodeprivkey=$privkey" >> /home/${COINl}/.${COINl}/${COINCONFIG}
# Inserting Version to nullentrydev files
if [[ $NULLREC = "y" ]] ; then
  echo "masterNode1 : true" >> /usr/local/nullentrydev/${COIN3l}.log
  echo "walletVersion1 : $COINVERSION" >> /usr/local/nullentrydev/${COIN3l}.log
  echo "scriptVersion1 : $SCRIPTVERSION" >> /usr/local/nullentrydev/${COIN3l}.log
fi
sleep 5
echo
# Starting First Masternode daemon
echo -e ${BOLD}"Launching First ${COIN3} Node"${CLEAR}
${COINDAEMON} -datadir=/home/${COINl}/.${COINl} -daemon
sleep 60
# Second Node Configuration and launch
echo -e "${GREEN}Configuring Second Node${CLEAR}"
sudo mkdir /home/${COINl}2/.${COINl}
sudo touch /home/${COINl}2/.${COINl}/${COINCONFIG}
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/${COINl}2/.${COINl}/${COINCONFIG}
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/${COINl}2/.${COINl}/${COINCONFIG}
echo "rpcallowip=127.0.0.1" >> /home/${COINl}2/.${COINl}/${COINCONFIG}
echo "server=1" >> /home/${COINl}2/.${COINl}/${COINCONFIG}
echo "daemon=1" >> /home/${COINl}2/.${COINl}/${COINCONFIG}
echo "maxconnections=250" >> /home/${COINl}2/.${COINl}/${COINCONFIG}
echo "masternode=1" >> /home/${COINl}2/.${COINl}/${COINCONFIG}
echo "rpcport=$COINPORT2" >> /home/${COINl}2/.${COINl}/${COINCONFIG}
echo "listen=0" >> /home/${COINl}2/.${COINl}/${COINCONFIG}
echo "externalip=[$(hostname -I | cut -f2 -d' ')]:$COINPORT" >> /home/${COINl}2/.${COINl}/${COINCONFIG}
echo "masternodeprivkey=$privkey2" >> /home/${COINl}2/.${COINl}/${COINCONFIG}
# Inserting Version to nullentrydev files
if [[ $NULLREC = "y" ]] ; then
  echo "masterNode2 : true" >> /usr/local/nullentrydev/${COIN3l}.log
  echo "walletVersion2 : $COINVERSION" >> /usr/local/nullentrydev/${COIN3l}.log
  echo "scriptVersion2 : $SCRIPTVERSION" >> /usr/local/nullentrydev/${COIN3l}.log
fi
sleep 5
echo
# Starting Second Masternode daemon
echo -e ${BOLD}"Launching Second ${COIN3} Node"${CLEAR}
${COINDAEMON} -datadir=/home/${COINl}2/.${COINl} -daemon
sleep 60
# Third Node Configuration and launch
echo -e "${GREEN}Configuring Third Node${CLEAR}"
sudo mkdir /home/${COINl}3/.${COINl}
sudo touch /home/${COINl}3/.${COINl}/${COINCONFIG}
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/${COINl}3/.${COINl}/${COINCONFIG}
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/${COINl}3/.${COINl}/${COINCONFIG}
echo "rpcallowip=127.0.0.1" >> /home/${COINl}3/.${COINl}/${COINCONFIG}
echo "server=1" >> /home/${COINl}3/.${COINl}/${COINCONFIG}
echo "daemon=1" >> /home/${COINl}3/.${COINl}/${COINCONFIG}
echo "maxconnections=250" >> /home/${COINl}3/.${COINl}/${COINCONFIG}
echo "masternode=1" >> /home/${COINl}3/.${COINl}/${COINCONFIG}
echo "rpcport=$COINPORT3" >> /home/${COINl}3/.${COINl}/${COINCONFIG}
echo "listen=0" >> /home/${COINl}3/.${COINl}/${COINCONFIG}
echo "externalip=$(hostname  -I | cut -f1 -d' '):5556" >> /home/${COINl}3/.${COINl}/${COINCONFIG}
echo "masternodeprivkey=$privkey3" >> /home/${COINl}3/.${COINl}/${COINCONFIG}
# Inserting Version to nullentrydev files
if [[ $NULLREC = "y" ]] ; then
  echo "masterNode3 : true" >> /usr/local/nullentrydev/${COIN3l}.log
  echo "walletVersion3 : $COINVERSION" >> /usr/local/nullentrydev/${COIN3l}.log
  echo "scriptVersion3 : $SCRIPTVERSION" >> /usr/local/nullentrydev/${COIN3l}.log
fi
sleep 5
echo
# Starting Third Masternode daemon
echo -e ${BOLD}"Launching Third ${COIN3} Node"${CLEAR}
${COINDAEMON} -datadir=/home/${COINl}3/.${COINl} -daemon
sleep 60
echo
echo -e ${BOLD}"All ${COIN3} Node Launched, please wait for it to sync".${CLEAR}
echo
echo -e "${BOLD}Your Masternodes are sync'ing this will take some time."${CLEAR}
echo -e "While you wait you can configure your masternode.conf in your local wallet"${CLEAR}
echo -e "The data below needs to be in your local masternode configuration file:${CLEAR}"
echo -e "${BOLD} Masternode_IP 1: $(hostname  -I | cut -f1 -d' '):${COINPORT}${CLEAR}"
echo -e "${BOLD} Masternode_IP 2: $(hostname  -I | cut -f2 -d' '):${COINPORT}${CLEAR}"
echo -e "${BOLD} Masternode_IP 3: $(hostname  -I | cut -f1 -d' '):5556${CLEAR}"
echo
echo -e ${BOLD} "If you become disconnected, you can check the status of sync'ing with"${CLEAR}
echo -e "${YELLOW}For ${COINDAEMONCLI} -datadir=/home/${COINl}/.${COINl} mnsync status"${CLEAR}
echo -e "${YELLOW}For ${COINDAEMONCLI} -datadir=/home/${COINl}2/.${COINl} mnsync status"${CLEAR}
echo -e "${YELLOW}For ${COINDAEMONCLI} -datadir=/home/${COINl}3/.${COINl} mnsync status"${CLEAR}
echo -e
echo -e ${BOLD}"You can check the status of your ${COIN3} Masternode with"${CLEAR}
echo -e "${YELLOW}For ${COINDAEMONCLI} -datadir=/home/${COINl}/.${COINl} masternode status"${CLEAR}
echo -e "${YELLOW}For ${COINDAEMONCLI} -datadir=/home/${COINl}2/.${COINl} masternode status"${CLEAR}
echo -e "${YELLOW}For ${COINDAEMONCLI} -datadir=/home/${COINl}3/.${COINl} masternode status"${CLEAR}
echo
fi
echo -e ${BLUE}" Your patronage is apprappreciated, tipping addresses"${CLEAR}
echo -e ${BLUE}" ${COIN} address: GZXonqnH2cjPgQZL59urDZS2CBzxPzoQ1j"${CLEAR}
echo -e ${BLUE}" LTC address: MUdDdVr4Az1dVw47uC4srJ31Ksi5SNkC7H"${CLEAR}
echo -e ${BLUE}" BTC address: 32FzghE1yUZRdDmCkj3bJ6vJyXxUVPKY93"${CLEAR}
echo
echo -e ${YELLOW}"Need help?  Find Sburns1369#1584 one Discord - https://discord.gg/YhJ8v3g"${CLEAR}
echo
echo
echo -e ${RED}"The END."${CLEAR};
