#!/bin/bash
#0.9d-- NullEntryDev Script
NODESL=Eight
NODESN=8
BLUE='\033[0;96m'
GREEN='\033[0;92m'
RED='\033[0;91m'
YELLOW='\033[0;93m'
CLEAR='\033[0m'
if [[ $(lsb_release -d) != *16.04* ]]; then
"echo -e ${RED}"The operating system is not Ubuntu 16.04. You must be running on ubuntu 16.04."${CLEAR}"
exit 1
fi
echo
echo
echo -e ${GREEN}"Are you sure you want to continue the installation of ${NODESL} GenesisX Masternodes?"
echo -e "type y/n followed by [ENTER]:"${CLEAR}
read AGREE
if [[ $AGREE =~ "y" ]] ; then
echo
echo
echo
echo
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
echo -e ${YELLOW}"And the script installation will hang and fail"${CLEAR}
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
echo -e ${GREEN}"Please Enter Your Fourth Masternode Private Key:"${CLEAR}
read privkey4
echo
echo -e ${GREEN}"Please Enter Your Fifth Masternode Private Key:"${CLEAR}
read privkey5
echo
echo -e ${GREEN}"Please Enter Your Sixth Masternode Private Key:"${CLEAR}
read privkey6
echo
echo -e ${GREEN}"Please Enter Your Seventh Masternode Private Key:"${CLEAR}
read privkey7
echo
echo -e ${GREEN}"Please Enter Your Eigth Masternode Private Key:"${CLEAR}
read privkey8
echo
echo "Creating ${NODESN} GenesisX system users with no-login access:"
sudo adduser --system --home /home/genesisx genesisx
sudo adduser --system --home /home/genesisx2 genesisx2
sudo adduser --system --home /home/genesisx3 genesisx3
sudo adduser --system --home /home/genesisx4 genesisx4
sudo adduser --system --home /home/genesisx5 genesisx5
sudo adduser --system --home /home/genesisx6 genesisx6
sudo adduser --system --home /home/genesisx7 genesisx7
sudo adduser --system --home /home/genesisx8 genesisx8
cd ~
if [[ $NULLREC = "y" ]] ; then
if [ ! -d /usr/local/nullentrydev/ ]; then
echo -e ${YELLOW}"Making /usr/local/nullentrydev"${CLEAR}
sudo mkdir /usr/local/nullentrydev
else
echo -e ${YELLOW}"Found /usr/local/nullentrydev"${CLEAR}
fi
if [ ! -f /usr/local/nullentrydev/xgs.log ]; then
echo -e ${YELLOW}"Making /usr/local/nullentrydev/xgs.log"${CLEAR}
sudo touch /usr/local/nullentrydev/xgs.log
else
echo -e ${YELLOW}"Found /usr/local/nullentrydev/xgs.log"${CLEAR}
fi
if [ ! -f /usr/local/nullentrydev/mnodes.log ]; then
echo -e ${YELLOW}"Making /usr/local/nullentrydev/mnodes.log"${CLEAR}
sudo touch /usr/local/nullentrydev/mnodes.log
else
echo -e ${YELLOW}"Found /usr/local/nullentrydev/mnodes.log"${CLEAR}
fi
fi
echo -e ${RED}"Updating Apps"${CLEAR}
sudo apt-get -y update
echo -e ${RED}"Upgrading Apps"${CLEAR}
sudo apt-get -y upgrade
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
echo -e ${RED}"Press [ENTER] if prompted"${CLEAR}
sudo add-apt-repository -yu ppa:bitcoin/bitcoin
sudo apt-get update
sudo apt-get -y install libdb4.8-dev
sudo apt-get -y install libdb4.8++-dev
echo -e ${YELLOW} "Here be dragons"${CLEAR}
sudo apt-get -y install libminiupnpc-dev libzmq3-dev libevent-pthreads-2.0-5
sudo apt-get -y install libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev
sudo apt-get -y install libqrencode-dev bsdmainutils unzip
if [[ $NULLREC = "y" ]] ; then
echo "dependenciesInstalled: true" >> /usr/local/nullentrydev/mnodes.log
fi
fi
echo -e ${YELLOW} "Building IP Tables"${CLEAR}
sudo touch ip.tmp
IP=$(hostname -I | cut -f2 -d' '| cut -f1-7 -d:)
for i in {15361..15375}; do printf "${IP}:%.4x\n" $i >> ip.tmp; done
MNIP1=$(sed -n '1p' < ip.tmp)
MNIP2=$(sed -n '2p' < ip.tmp)
MNIP3=$(sed -n '3p' < ip.tmp)
MNIP4=$(sed -n '4p' < ip.tmp)
MNIP5=$(sed -n '5p' < ip.tmp)
MNIP6=$(sed -n '6p' < ip.tmp)
MNIP7=$(sed -n '7p' < ip.tmp)
MNIP8=$(sed -n '8p' < ip.tmp)
if [[ $NULLREC = "y" ]] ; then
sudo touch /usr/local/nullentrydev/iptable.log
sudo cp ip.tmp >> /usr/local/nullentrydev/iptable.log
fi
rm -rf ip.tmp
cd /var
sudo touch swap.img
sudo chmod 600 swap.img
sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=4096
sudo mkswap /var/swap.img
sudo swapon /var/swap.img
cd ~
if [ ! -d /root/xgs ]; then
sudo mkdir /root/xgs
fi
cd /root/xgs
echo "Downloading latest GenesisX binaries"
wget https://github.com/genesis-x/genesis-x/files/2799605/genesisx-linux.zip
unzip genesisx-linux.zip
sleep 3
sudo mv /root/xgs/genesisxd /root/xgs/genesisx-cli /usr/local/bin
sudo chmod 755 -R /usr/local/bin/genesisx*
rm -rf /root/xgs
echo -e "${GREEN}Configuring First GenesisX Node${CLEAR}"
sudo mkdir /home/genesisx/.genesisx
sudo touch /home/genesisx/.genesisx/genesisx.conf
echo "rpcuser=user"`shuf -i 100000-9999999 -n 1` >> /home/genesisx/.genesisx/genesisx.conf
echo "rpcpassword=pass"`shuf -i 100000-9999999 -n 1` >> /home/genesisx/.genesisx/genesisx.conf
echo "rpcallowip=127.0.0.1" >> /home/genesisx/.genesisx/genesisx.conf
echo "server=1" >> /home/genesisx/.genesisx/genesisx.conf
echo "daemon=1" >> /home/genesisx/.genesisx/genesisx.conf
echo "maxconnections=250" >> /home/genesisx/.genesisx/genesisx.conf
echo "masternode=1" >> /home/genesisx/.genesisx/genesisx.conf
echo "rpcport=19012" >> /home/genesisx/.genesisx/genesisx.conf
echo "listen=0" >> /home/genesisx/.genesisx/genesisx.conf
echo "externalip=[${MNIP1}]:5555" >> /home/genesisx/.genesisx/genesisx.conf
echo "masternodeprivkey=$privkey" >> /home/genesisx/.genesisx/genesisx.conf
if [[ $NULLREC = "y" ]] ; then
echo "masterNode1 : true" >> /usr/local/nullentrydev/xgs.log
echo "walletVersion1 : 1.4.0COINVERSION=1.6.0" >> /usr/local/nullentrydev/xgs.log
echo "scriptVersion1 : 0.9d" >> /usr/local/nullentrydev/xgs.log
fi
sleep 5
echo
echo -e ${YELLOW}"Launching first XGS Node"${CLEAR}
genesisxd -datadir=/home/genesisx/.genesisx -daemon
echo
echo -e ${YELLOW}"Looking for a Shared Masternode Service? Check out Crypto Hash Tank" ${CLEAR}
echo -e ${YELLOW}"Support my Project, and put your loose change to work for you!" ${CLEAR}
echo -e ${YELLOW}" https://www.cryptohashtank.com/TJIF "${CLEAR}
echo
echo -e ${YELLOW}"Special Thanks to the BitcoinGenX (BGX) Community" ${CLEAR}
echo
sleep 20
echo -e "${GREEN}Configuring second GenesisX Node${CLEAR}"
sudo mkdir /home/genesisx2/.genesisx
sudo touch /home/genesisx2/genesisx.conf
echo "rpcuser=user"`shuf -i 100000-9999999 -n 1` >> /home/genesisx2/genesisx.conf
echo "rpcpassword=pass"`shuf -i 100000-9999999 -n 1` >> /home/genesisx2/genesisx.conf
echo "rpcallowip=127.0.0.1" >> /home/genesisx2/genesisx.conf
echo "server=1" >> /home/genesisx2/genesisx.conf
echo "daemon=1" >> /home/genesisx2/genesisx.conf
echo "maxconnections=250" >> /home/genesisx2/genesisx.conf
echo "masternode=1" >> /home/genesisx2/genesisx.conf
echo "rpcport=19013" >> /home/genesisx2/genesisx.conf
echo "listen=0" >> /home/genesisx2/genesisx.conf
echo "externalip=[${MNIP2}]:5555" >> /home/genesisx2/genesisx.conf
echo "masternodeprivkey=$privkey2" >> /home/genesisx2/genesisx.conf
if [[ $NULLREC = "y" ]] ; then
echo "masterNode2 : true" >> /usr/local/nullentrydev/xgs.log
echo "walletVersion2 : 1.4.0COINVERSION=1.6.0" >> /usr/local/nullentrydev/xgs.log
echo "scriptVersion2 : 0.9d" >> /usr/local/nullentrydev/xgs.log
fi
sleep 5
echo
echo -e "${GREEN}Configuring third GenesisX Node${CLEAR}"
sudo mkdir /home/genesisx3/.genesisx
sudo touch /home/genesisx3/genesisx.conf
echo "rpcuser=user"`shuf -i 100000-9999999 -n 1` >> /home/genesisx3/genesisx.conf
echo "rpcpassword=pass"`shuf -i 100000-9999999 -n 1` >> /home/genesisx3/genesisx.conf
echo "rpcallowip=127.0.0.1" >> /home/genesisx3/genesisx.conf
echo "server=1" >> /home/genesisx3/genesisx.conf
echo "daemon=1" >> /home/genesisx3/genesisx.conf
echo "maxconnections=250" >> /home/genesisx3/genesisx.conf
echo "masternode=1" >> /home/genesisx3/genesisx.conf
echo "rpcport=19014" >> /home/genesisx3/genesisx.conf
echo "listen=0" >> /home/genesisx3/genesisx.conf
echo "externalip=[${MNIP3}]:5555" >> /home/genesisx3/genesisx.conf
echo "masternodeprivkey=$privkey3" >> /home/genesisx3/genesisx.conf
if [[ $NULLREC = "y" ]] ; then
echo "masterNode3 : true" >> /usr/local/nullentrydev/xgs.log
echo "walletVersion3 : 1.4.0COINVERSION=1.6.0" >> /usr/local/nullentrydev/xgs.log
echo "scriptVersion3 : 0.9d" >> /usr/local/nullentrydev/xgs.log
fi
sleep 5
echo
echo -e "${GREEN}Configuring fourth GenesisX Node${CLEAR}"
sudo mkdir /home/genesisx4/.genesisx
sudo touch /home/genesisx4/genesisx.conf
echo "rpcuser=user"`shuf -i 100000-9999999 -n 1` >> /home/genesisx4/genesisx.conf
echo "rpcpassword=pass"`shuf -i 100000-9999999 -n 1` >> /home/genesisx4/genesisx.conf
echo "rpcallowip=127.0.0.1" >> /home/genesisx4/genesisx.conf
echo "server=1" >> /home/genesisx4/genesisx.conf
echo "daemon=1" >> /home/genesisx4/genesisx.conf
echo "maxconnections=250" >> /home/genesisx4/genesisx.conf
echo "masternode=1" >> /home/genesisx4/genesisx.conf
echo "rpcport=19015" >> /home/genesisx4/genesisx.conf
echo "listen=0" >> /home/genesisx4/genesisx.conf
echo "externalip=[${MNIP4}]:5555" >> /home/genesisx4/genesisx.conf
echo "masternodeprivkey=$privkey4" >> /home/genesisx4/genesisx.conf
if [[ $NULLREC = "y" ]] ; then
echo "masterNode4 : true" >> /usr/local/nullentrydev/xgs.log
echo "walletVersion4 : 1.4.0COINVERSION=1.6.0" >> /usr/local/nullentrydev/xgs.log
echo "scriptVersion4 : 0.9d" >> /usr/local/nullentrydev/xgs.log
fi
sleep 5
echo
echo -e "${GREEN}Configuring fifth GenesisX Node${CLEAR}"
sudo mkdir /home/genesisx5/.genesisx
sudo touch /home/genesisx5/genesisx.conf
echo "rpcuser=user"`shuf -i 100000-9999999 -n 1` >> /home/genesisx5/genesisx.conf
echo "rpcpassword=pass"`shuf -i 100000-9999999 -n 1` >> /home/genesisx5/genesisx.conf
echo "rpcallowip=127.0.0.1" >> /home/genesisx5/genesisx.conf
echo "server=1" >> /home/genesisx5/genesisx.conf
echo "daemon=1" >> /home/genesisx5/genesisx.conf
echo "maxconnections=250" >> /home/genesisx5/genesisx.conf
echo "masternode=1" >> /home/genesisx5/genesisx.conf
echo "rpcport=19016" >> /home/genesisx5/genesisx.conf
echo "listen=0" >> /home/genesisx5/genesisx.conf
echo "externalip=[${MNIP5}]:5555" >> /home/genesisx5/genesisx.conf
echo "masternodeprivkey=$privkey5" >> /home/genesisx5/genesisx.conf
if [[ $NULLREC = "y" ]] ; then
echo "masterNode5 : true" >> /usr/local/nullentrydev/xgs.log
echo "walletVersion5 : 1.4.0COINVERSION=1.6.0" >> /usr/local/nullentrydev/xgs.log
echo "scriptVersion5 : 0.9d" >> /usr/local/nullentrydev/xgs.log
fi
sleep 5
echo
echo -e "${GREEN}Configuring sixth GenesisX Node${CLEAR}"
sudo mkdir /home/genesisx6/.genesisx
sudo touch /home/genesisx6/genesisx.conf
echo "rpcuser=user"`shuf -i 100000-9999999 -n 1` >> /home/genesisx6/genesisx.conf
echo "rpcpassword=pass"`shuf -i 100000-9999999 -n 1` >> /home/genesisx6/genesisx.conf
echo "rpcallowip=127.0.0.1" >> /home/genesisx6/genesisx.conf
echo "server=1" >> /home/genesisx6/genesisx.conf
echo "daemon=1" >> /home/genesisx6/genesisx.conf
echo "maxconnections=250" >> /home/genesisx6/genesisx.conf
echo "masternode=1" >> /home/genesisx6/genesisx.conf
echo "rpcport=19017" >> /home/genesisx6/genesisx.conf
echo "listen=0" >> /home/genesisx6/genesisx.conf
echo "externalip=[${MNIP6}]:5555" >> /home/genesisx6/genesisx.conf
echo "masternodeprivkey=$privkey6" >> /home/genesisx6/genesisx.conf
if [[ $NULLREC = "y" ]] ; then
echo "masterNode6 : true" >> /usr/local/nullentrydev/xgs.log
echo "walletVersion6 : 1.4.0COINVERSION=1.6.0" >> /usr/local/nullentrydev/xgs.log
echo "scriptVersion6 : 0.9d" >> /usr/local/nullentrydev/xgs.log
fi
sleep 5
echo
echo -e "${GREEN}Configuring seventh GenesisX Node${CLEAR}"
sudo mkdir /home/genesisx7/.genesisx
sudo touch /home/genesisx7/genesisx.conf
echo "rpcuser=user"`shuf -i 100000-9999999 -n 1` >> /home/genesisx7/genesisx.conf
echo "rpcpassword=pass"`shuf -i 100000-9999999 -n 1` >> /home/genesisx7/genesisx.conf
echo "rpcallowip=127.0.0.1" >> /home/genesisx7/genesisx.conf
echo "server=1" >> /home/genesisx7/genesisx.conf
echo "daemon=1" >> /home/genesisx7/genesisx.conf
echo "maxconnections=250" >> /home/genesisx7/genesisx.conf
echo "masternode=1" >> /home/genesisx7/genesisx.conf
echo "rpcport=19018" >> /home/genesisx7/genesisx.conf
echo "listen=0" >> /home/genesisx7/genesisx.conf
echo "externalip=[${MNIP7}]:5555" >> /home/genesisx7/genesisx.conf
echo "masternodeprivkey=$privkey7" >> /home/genesisx7/genesisx.conf
if [[ $NULLREC = "y" ]] ; then
echo "masterNode7 : true" >> /usr/local/nullentrydev/xgs.log
echo "walletVersion7 : 1.4.0COINVERSION=1.6.0" >> /usr/local/nullentrydev/xgs.log
echo "scriptVersion7 : 0.9d" >> /usr/local/nullentrydev/xgs.log
fi
sleep 5
echo
echo -e "${GREEN}Configuring eigth GenesisX Node${CLEAR}"
sudo mkdir /home/genesisx8/.genesisx
sudo touch /home/genesisx8/genesisx.conf
echo "rpcuser=user"`shuf -i 100000-9999999 -n 1` >> /home/genesisx8/genesisx.conf
echo "rpcpassword=pass"`shuf -i 100000-9999999 -n 1` >> /home/genesisx8/genesisx.conf
echo "rpcallowip=127.0.0.1" >> /home/genesisx8/genesisx.conf
echo "server=1" >> /home/genesisx8/genesisx.conf
echo "daemon=1" >> /home/genesisx8/genesisx.conf
echo "maxconnections=250" >> /home/genesisx8/genesisx.conf
echo "masternode=1" >> /home/genesisx8/genesisx.conf
echo "rpcport=19019" >> /home/genesisx8/genesisx.conf
echo "listen=0" >> /home/genesisx8/genesisx.conf
echo "externalip=[${MNIP8}]:5555" >> /home/genesisx8/genesisx.conf
echo "masternodeprivkey=$privkey8" >> /home/genesisx8/genesisx.conf
if [[ $NULLREC = "y" ]] ; then
echo "masterNode8 : true" >> /usr/local/nullentrydev/xgs.log
echo "walletVersion8 : 1.4.0COINVERSION=1.6.0" >> /usr/local/nullentrydev/xgs.log
echo "scriptVersion8 : 0.9d" >> /usr/local/nullentrydev/xgs.log
fi
sleep 5
echo
echo -e "${RED}This process can take a while!${CLEAR}"
echo -e "${YELLOW}Waiting on First Masternode Block Chain to Synchronize${CLEAR}"
echo -e "${YELLOW}Once complete, it will stop and copy the block chain to${CLEAR}"
echo -e "${YELLOW}the other masternodes. This prevent all masternodes${CLEAR}"
echo -e "${YELLOW}from downloading the block chain individually; taking up${CLEAR}"
echo -e "${YELLOW}more time and resources. Current Block count will be displayed below.${CLEAR}"
until genesisx-cli -datadir=/home/genesisx/.genesisx mnsync status | grep -m 1 'IsBlockchainSynced" : true'; do
genesisx-cli -datadir=/home/genesisx/.genesisx getblockcount
sleep 60
done
echo -e "${GREEN}Haulting and Replicating First GenesisX Node${CLEAR}"

genesisx-cli -datadir=/home/genesisx/.genesisx stop
sleep 10
sudo cp -r /home/genesisx/.genesisx/* /home/genesisx2/.genesisx
sleep 3
sudo cp -r /home/genesisx/.genesisx/* /home/genesisx3/.genesisx
sleep 3
sudo cp -r /home/genesisx/.genesisx/* /home/genesisx4/.genesisx
sleep 3
sudo cp -r /home/genesisx/.genesisx/* /home/genesisx5/.genesisx
sleep 3
sudo cp -r /home/genesisx/.genesisx/* /home/genesisx6/.genesisx
sleep 3
sudo cp -r /home/genesisx/.genesisx/* /home/genesisx7/.genesisx
sleep 3
sudo cp -r /home/genesisx/.genesisx/* /home/genesisx8/.genesisx
sleep 3
rm /home/genesisx2/.genesisx/genesisx.conf
sleep 1
rm /home/genesisx3/.genesisx/genesisx.conf
sleep 1
rm /home/genesisx4/.genesisx/genesisx.conf
sleep 1
rm /home/genesisx5/.genesisx/genesisx.conf
sleep 1
rm /home/genesisx6/.genesisx/genesisx.conf
sleep 1
rm /home/genesisx7/.genesisx/genesisx.conf
sleep 1
rm /home/genesisx8/.genesisx/genesisx.conf
sleep 1
cp -r /home/genesisx2/genesisx.conf /home/genesisx2/.genesisx/genesisx.conf
sleep 1
cp -r /home/genesisx3/genesisx.conf /home/genesisx3/.genesisx/genesisx.conf
sleep 1
cp -r /home/genesisx4/genesisx.conf /home/genesisx4/.genesisx/genesisx.conf
sleep 1
cp -r /home/genesisx5/genesisx.conf /home/genesisx5/.genesisx/genesisx.conf
sleep 1
cp -r /home/genesisx6/genesisx.conf /home/genesisx6/.genesisx/genesisx.conf
sleep 1
cp -r /home/genesisx7/genesisx.conf /home/genesisx7/.genesisx/genesisx.conf
sleep 1
cp -r /home/genesisx8/genesisx.conf /home/genesisx8/.genesisx/genesisx.conf
sleep 1
echo -e ${YELLOW}"Launching First XGS Node"${CLEAR}
genesisxd -datadir=/home/genesisx/.genesisx -daemon
sleep 20
echo -e ${YELLOW}"Launching Second XGS Node"${CLEAR}
genesisxd -datadir=/home/genesisx2/.genesisx -daemon
sleep 20
echo -e ${YELLOW}"Launching Third XGS Node"${CLEAR}
genesisxd -datadir=/home/genesisx3/.genesisx -daemon
sleep 20
echo -e ${YELLOW}"Launching Fourth XGS Node"${CLEAR}
genesisxd -datadir=/home/genesisx4/.genesisx -daemon
sleep 20
echo -e ${YELLOW}"Launching Fifth XGS Node"${CLEAR}
genesisxd -datadir=/home/genesisx5/.genesisx -daemon
sleep 20
echo -e ${YELLOW}"Launching Sixth XGS Node"${CLEAR}
genesisxd -datadir=/home/genesisx6/.genesisx -daemon
sleep 20
echo -e ${YELLOW}"Launching Seventh XGS Node"${CLEAR}
genesisxd -datadir=/home/genesisx7/.genesisx -daemon
sleep 20
echo -e ${YELLOW}"Launching Eigth XGS Node"${CLEAR}
genesisxd -datadir=/home/genesisx8/.genesisx -daemon
sleep 20
echo -e ${BOLD}"All ${NODESN} XGS Nodes Launched".${CLEAR}
echo

echo -e "${GREEN}You can check the status of your XGS Masternode with"${CLEAR}
echo -e "${YELLOW} genesisx-cli -datadir=/home/genesisx/.genesisx masternode status"${CLEAR}
echo -e "${YELLOW}For mn1: \"genesisx-cli -datadir=/home/genesisx/.genesisx masternode status\""${CLEAR}
echo -e "${YELLOW}For mn2: \"genesisx-cli -datadir=/home/genesisx2/.genesisx masternode status\""${CLEAR}
echo -e "${YELLOW}For mn3: \"genesisx-cli -datadir=/home/genesisx3/.genesisx masternode status\""${CLEAR}
echo -e "${YELLOW}For mn4: \"genesisx-cli -datadir=/home/genesisx4/.genesisx masternode status\""${CLEAR}
echo -e "${YELLOW}For mn5: \"genesisx-cli -datadir=/home/genesisx5/.genesisx masternode status\""${CLEAR}
echo -e "${YELLOW}For mn6: \"genesisx-cli -datadir=/home/genesisx6/.genesisx masternode status\""${CLEAR}
echo -e "${YELLOW}For mn7: \"genesisx-cli -datadir=/home/genesisx7/.genesisx masternode status\""${CLEAR}
echo -e "${YELLOW}For mn8: \"genesisx-cli -datadir=/home/genesisx8/.genesisx masternode status\""${CLEAR}
echo
echo -e "${RED}Status 29 may take a few minutes to clear while the daemon processes the chainstate"${CLEAR}
echo -e "${GREEN}The data below needs to be in your local masternode configuration file:${CLEAR}"
echo -e "${BOLD} Masternode - \#1 IP: [${MNIP1}]:5555${CLEAR}"
echo -e "${BOLD} Masternode - \#2 IP: [${MNIP2}]:5555${CLEAR}"
echo -e "${BOLD} Masternode - \#3 IP: [${MNIP3}]:5555${CLEAR}"
echo -e "${BOLD} Masternode - \#4 IP: [${MNIP4}]:5555${CLEAR}"
echo -e "${BOLD} Masternode - \#5 IP: [${MNIP5}]:5555${CLEAR}"
echo -e "${BOLD} Masternode - \#6 IP: [${MNIP6}]:5555${CLEAR}"
echo -e "${BOLD} Masternode - \#7 IP: [${MNIP7}]:5555${CLEAR}"
echo -e "${BOLD} Masternode - \#8 IP: [${MNIP8}]:5555${CLEAR}"
fi
echo -e ${BLUE}" Your patronage is appreciated, tipping addresses"${CLEAR}
echo -e ${BLUE}" GenesisX address: GcToAa57WXPsVwXB9LKvui215AC3bsvneA"${CLEAR}
echo -e ${BLUE}" XGS address: BayScFpFgPBiDU1XxdvozJYVzM2BQvNFgM"${CLEAR}
echo -e ${BLUE}" LTC address: MUdDdVr4Az1dVw47uC4srJ31Ksi5SNkC7H"${CLEAR}
echo
echo -e ${YELLOW}"Need help? Find Sburns1369\#1584 on Discord - https://discord.gg/YhJ8v3g"${CLEAR}
echo -e ${YELLOW}"If Direct Messaged please verify by clicking on the profile!"${CLEAR}
echo -e ${YELLOW}"it says Sburns1369 in bigger letters followed by a little #1584" ${CLEAR}
echo -e ${YELLOW}"Anyone can clone my name, but not the #1384".${CLEAR}
echo
echo -e ${RED}"The END."${CLEAR};
