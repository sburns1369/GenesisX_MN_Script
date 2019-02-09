#!/bin/bash
#ScriptVersion 0.06a
COIN=GenesisX
COINPORT=5555
COINRPCPORT=19012
COINDAEMON=genesisd
COINDAEMONCLI=genesis-cli
COINCORE=.genesis
COINCONFIG=genesis.conf
#Setting Colors
BLUE='\033[0;96m'
GREEN='\033[0;92m'
RED='\033[0;91m'
YELLOW='\033[0;93m'
#clear font
CLEAR='\033[0m'

#Checking OS - double check incase script ran directly
if [[ $(lsb_release -d) != *16.04* ]]; then
  echo -e ${RED}"The operating system is not Ubuntu 16.04. You must be running on ubuntu 16.04."${CLEAR}
  exit 1
fi
echo -e ${GREEN}"Are you sure you want to continue installation of a GenesisX Masternode?"
echo -e "type y/n followed by [ENTER]:"${CLEAR}
read AGREE
if [[ $AGREE =~ "y" ]] ; then
echo
echo -e ${GREEN}"Your Masternode Private Key is needed, which can be generated from the local wallet"${CLEAR}
echo -e ${YELLOW}"You can edit the config later if you don't have this"${CLEAR}
echo -e ${YELLOW}"Masternode may fail to start with invalid key"${CLEAR}
echo
echo -e ${GREEN}"Right Click to paste in some SSH Clients"${CLEAR}
echo -e ${GREEN}"Please Enter Your First Masternode Private Key:"${CLEAR}
read privkey
echo
echo -e ${GREEN}"Please Enter Your Second Masternode Private Key:"${CLEAR}
read privkey2
echo
echo -e ${GREEN}"Please Enter Your Third Masternode Private Key:"${CLEAR}
read privkey3
echo
echo -e ${GREEN}"Please Enter Your Fourth Masternode Private Key:"${CLEAR}
read privkey4
echo
echo "Creating 4 GenesisX system users with no-login access:"
sudo adduser --system --home /home/genesisx genesisx
sudo adduser --system --home /home/genesisx2 genesisx2
sudo adduser --system --home /home/genesisx3 genesisx3
sudo adduser --system --home /home/genesisx4 genesisx4
echo "Updating Apps"
sudo apt-get -y update
sudo apt-get -y upgrade
echo "Installing Dependencies & Software Libraries"
sudo apt-get -y install software-properties-common
sudo apt-get -y install build-essential
echo -e ${YELLOW} "This script was written in the dark"${CLEAR}
sudo apt-get -y install libtool autotools-dev autoconf automake
sudo apt-get -y install libssl-dev
sudo apt-get -y install libevent-dev
sudo apt-get -y install libboost-all-dev
sudo apt-get -y install pkg-config
echo -e ${RED}"Press ENTER when prompted"${CLEAR}
sudo add-apt-repository ppa:bitcoin/bitcoin
sudo apt-get update
sudo apt-get -y install libdb4.8-dev
sudo apt-get -y install libdb4.8++-dev
sudo apt-get -y install libminiupnpc-dev libzmq3-dev libevent-pthreads-2.0-5
sudo apt-get -y install libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev
sudo apt-get -y install libqrencode-dev bsdmainutils unzip
cd /var
sudo touch swap.img
sudo chmod 600 swap.img
sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=4096
sudo mkswap /var/swap.img
sudo swapon /var/swap.img
cd ~
sudo mkdir /root/xgs
cd /root/xgs
echo "Downloading latest binaries"
wget https://github.com/genesis-x/genesis-x/files/2799605/genesisx-linux.zip
unzip genesisx-linux.zip
sudo mv /root/xgs/genesisxd /root/xgs/genesisx-cli /usr/local/bin
sudo chmod 755 -R  /usr/local/bin/genesisx*
rm -rf /root/xgs
echo -e "${GREEN}Configuring First node${CLEAR}"
sudo mkdir /home/genesisx/.genesisx
sudo touch /home/genesisx/.genesisx/genesisx.conf
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/genesisx/.genesisx/genesisx.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/genesisx/.genesisx/genesisx.conf
echo "rpcallowip=127.0.0.1" >> /home/genesisx/.genesisx/genesisx.conf
echo "server=1" >> /home/genesisx/.genesisx/genesisx.conf
echo "daemon=1" >> /home/genesisx/.genesisx/genesisx.conf
echo "maxconnections=250" >> /home/genesisx/.genesisx/genesisx.conf
echo "masternode=1" >> /home/genesisx/.genesisx/genesisx.conf
echo "rpcport=$COINPORT" >> /home/genesisx/.genesisx/genesisx.conf
echo "listen=0" >> /home/genesisx/.genesisx/genesisx.conf
echo "externalip=$(hostname  -I | cut -f1 -d' '):$COINPORT" >> /home/genesisx/.genesisx/genesisx.conf
echo "masternodeprivkey=$privkey" >> /home/genesisx/.genesisx/genesisx.conf
sleep 5
echo "${BOLD}${RED}Launching First Node"${CLEAR}
genesisxd -datadir=/home/genesisx/.genesisx -daemon
sleep 60
echo -e "${GREEN}Configuring Second node${CLEAR}"
sudo mkdir /home/genesisx2/.genesisx
sudo touch /home/genesisx2/.genesisx/genesisx.conf
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/genesisx2/.genesisx/genesisx.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/genesisx2/.genesisx/genesisx.conf
echo "rpcallowip=127.0.0.1" >> /home/genesisx2/.genesisx/genesisx.conf
echo "server=1" >> /home/genesisx2/.genesisx/genesisx.conf
echo "daemon=1" >> /home/genesisx2/.genesisx/genesisx.conf
echo "maxconnections=250" >> /home/genesisx2/.genesisx/genesisx.conf
echo "masternode=1" >> /home/genesisx2/.genesisx/genesisx.conf
echo "rpcport=$5556" >> /home/genesisx2/.genesisx/genesisx.conf
echo "listen=0" >> /home/genesisx2/.genesisx/genesisx.conf
echo "externalip=$(hostname  -I | cut -f1 -d' '):$COINPORT" >> /home/genesisx2/.genesisx/genesisx.conf
echo "masternodeprivkey=$privkey2" >> /home/genesisx2/.genesisx/genesisx.conf
sleep 5
echo "${BOLD}${RED}Launching Second Node"${CLEAR}
genesisxd -datadir=/home/genesisx2/.genesisx -daemon
sleep 60
echo -e "${GREEN}Configuring Third node${CLEAR}"
sudo mkdir /home/genesisx3/.genesisx
sudo touch /home/genesisx3/.genesisx/genesisx.conf
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/genesisx3/.genesisx/genesisx.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/genesisx3/.genesisx/genesisx.conf
echo "rpcallowip=127.0.0.1" >> /home/genesisx3/.genesisx/genesisx.conf
echo "server=1" >> /home/genesisx3/.genesisx/genesisx.conf
echo "daemon=1" >> /home/genesisx3/.genesisx/genesisx.conf
echo "maxconnections=250" >> /home/genesisx3/.genesisx/genesisx.conf
echo "masternode=1" >> /home/genesisx3/.genesisx/genesisx.conf
echo "rpcport=$5556" >> /home/genesisx3/.genesisx/genesisx.conf
echo "listen=0" >> /home/genesisx3/.genesisx/genesisx.conf
echo "externalip=$(hostname  -I | cut -f1 -d' '):$COINPORT" >> /home/genesisx3/.genesisx/genesisx.conf
echo "masternodeprivkey=$privkey3" >> /home/genesisx3/.genesisx/genesisx.conf
sleep 5
echo "${BOLD}${RED}Launching Third Node"${CLEAR}
genesisxd -datadir=/home/genesisx3/.genesisx -daemon
sleep 60
echo -e "${GREEN}Configuring Fourth node${CLEAR}"
sudo mkdir /home/genesisx4/.genesisx
sudo touch /home/genesisx4/.genesisx/genesisx.conf
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /home/genesisx4/.genesisx/genesisx.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /home/genesisx4/.genesisx/genesisx.conf
echo "rpcallowip=127.0.0.1" >> /home/genesisx4/.genesisx/genesisx.conf
echo "server=1" >> /home/genesisx4/.genesisx/genesisx.conf
echo "daemon=1" >> /home/genesisx4/.genesisx/genesisx.conf
echo "maxconnections=250" >> /home/genesisx4/.genesisx/genesisx.conf
echo "masternode=1" >> /home/genesisx4/.genesisx/genesisx.conf
echo "rpcport=$5556" >> /home/genesisx4/.genesisx/genesisx.conf
echo "listen=0" >> /home/genesisx4/.genesisx/genesisx.conf
echo "externalip=$(hostname  -I | cut -f1 -d' '):$COINPORT" >> /home/genesisx4/.genesisx/genesisx.conf
echo "masternodeprivkey=$privkey4" >> /home/genesisx4/.genesisx/genesisx.conf
sleep 5
echo "${BOLD}${RED}Launching Fourth Node"${CLEAR}
genesisxd -datadir=/home/genesisx4/.genesisx -daemon
sleep 60
echo " Nodes Launched, please wait for them to sync".
echo
echo -e "${BOLD}Your Masternodes are sync'ing this will take some time.${CLEAR}"
echo -e "While you wait you can configure your masternode.conf in your local wallet"${CLEAR}
echo -e "The following data needs to be recorded in your local masternode configuration file:${CLEAR}"
echo -e "${BOLD}${RED} Masternode_IP: $(hostname  -I | cut -f1 -d' '):${COINPORT}${CLEAR}"
echo
echo -e ${BOLD}${YELLOW}"If you become disconnected, you can check the status of sync'ing with"${CLEAR}
echo -e "${BOLD}For MN#1- genesisx-cli -datadir=/home/genesisx/.genesisx mnsync status"${CLEAR}
echo -e "${BOLD}For MN#2- genesisx-cli -datadir=/home/genesisx2/.genesisx mnsync status"${CLEAR}
echo -e "${BOLD}For MN#3- genesisx-cli -datadir=/home/genesisx3/.genesisx mnsync status"${CLEAR}
echo -e
echo -e ${BOLD}${YELLOW}"You can check the status of your masternode with"${CLEAR}
echo -e "${BOLD}For MN#1- genesisx-cli -datadir=/home/genesisx/.genesisx masternode status"${CLEAR}
echo -e "${BOLD}For MN#2- genesisx-cli -datadir=/home/genesisx2/.genesisx masternode status"${CLEAR}
echo -e "${BOLD}For MN#3- genesisx-cli -datadir=/home/genesisx3/.genesisx masternode status"${CLEAR}
echo
fi
echo ${BOLD}${BLUE}"Your patronage is apprappreciated, tipping addresses"${CLEAR}
echo ${BLUE}"GenesisxNet address: GZXonqnH2cjPgQZL59urDZS2CBzxPzoQ1j"${CLEAR}
echo ${BLUE}"LTC address: MUdDdVr4Az1dVw47uC4srJ31Ksi5SNkC7H"${CLEAR}
echo ${BLUE}"BTC address: 32FzghE1yUZRdDmCkj3bJ6vJyXxUVPKY93"${CLEAR}
echo
echo "Need help?  Find Sburns1369#1584 one Discord - https://discord.gg/YhJ8v3g"
echo
echo
echo ${RED}"The END."${CLEAR};