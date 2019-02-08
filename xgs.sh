#!/bin/bash
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

echo -e ${YELLOW}"Welcome to the NullDev - Genesis Automated Install - Version 0.01"${CLEAR}
echo
echo -e ${YELLOW} "Durring this Process Please Hit Enter or Input What is Asked."${CLEAR}
echo
echo
echo -e ${YELLOW}"it's supposed to do that. This process can take up to an hour"${CLEAR}
echo
echo -e ${YELLOW} "The script may appear stuck, but please wait.  It will notify you upon completion"${CLEAR}
echo
echo -e ${GREEN}"Are you sure you want to continue installation of GenesisX Masternode(s)?"
echo -e "type y/n followed by [ENTER]:"${CLEAR}
read AGREE

if [[ $AGREE =~ "y" ]] ; then
echo -e ${GREEN}"Please Enter Your Masternodes Private Key for the first node:"${CLEAR}
read privkey
echo -e ${GREEN}"Please Enter Your Masternodes Private Key for second node:"${CLEAR}
read privkey2
echo "Creating 2 GenesisX system users with no-login access:"
sudo adduser --system --home /home/genesisx genesisx
sudo adduser --system --home /home/genesisx2 genesisx2
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
sudo echo ' /var/swap.img none swap sw 0 0 ' >> /etc/fstab
cd ~
sudo mkdir /root/xgs
cd /root/xgs
echo "Downloading latest binaries"
wget https://github.com/genesis-x/genesis-x/files/2799605/genesisx-linux.zip
unzip genesisx-linux.zip
sudo mv /root/xgs/genesisxd /root/xgs/genesisx-cli /usr/local/bin
sudo chmod 755 -R  /usr/local/bin/genesisx*
rm -rf /root/xgs
sudo mkdir /home/genesisx/.genesisx
sudo touch /home/genesisx/.genesisx/genesisx.conf
echo -e "${GREEN}Configuring First node${CLEAR}"
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
fi
echo "Launching First Node";
genesisxd -datadir=/home/genesisx/.genesisx -daemon
sleep 10
echo "Launching Second Node";
genesisxd -datadir=/home/genesisx2/.genesisx -daemon
sleep 10
echo "Both Nodes Launched, please wait for confirmation!"
echo -e "${BOLD}Your Masternodes are sync'ing this will take some time.${CLEAR}"
echo -e "While you wait you can configure your masternode.conf in your local wallet"${CLEAR}
echo -e "The following data needs to be recorded in your local masternode configuration file:${CLEAR}"
echo -e "${BOLD}${YELLOW} Masternode_IP: $(hostname  -I | cut -f1 -d' '):${COINPORT}${CLEAR}"
echo
echo -e "If you become disconnected, you can check the status of sync'ing with"
echo -e "${BOLD}genesisx-cli -datadir=/home/genesisx/.genesisx mnsync status"${CLEAR}
echo -e
echo -e "You can check the status of your masternode with"
echo -e "${BOLD}genesisx-cli -datadir=/home/genesisx/.genesisx masternode status"${CLEAR}
echo
echo "Your patronage is apprappreciated, tipping addresses"
echo "GenesisxNet address: GZXonqnH2cjPgQZL59urDZS2CBzxPzoQ1j"
echo "LTC address: MBcadY5G6fWSsQzVbZzAKrnNyb5NdRQkLC"
echo "BTC address: 3KQdz2HUGWJ9vteSeGW9F4vD8jxv1Y7Z9k "
echo
echo "The END. You can close now the SSH terminal session";
