echo -e ${GREEN}"Please Enter Your Fourth Masternode Private Key:"${CLEAR}
read privkey4
sudo adduser --system --home /home/genesisx4 genesisx4
echo -e ${YELLOW} "Building IP Tables"${CLEAR}
sudo touch ip.tmp
IP=$(hostname -I | cut -f2 -d' '| cut -f1-7 -d:)
for i in {15361..15375}; do printf "${IP}:%.4x\n" $i >> ip.tmp; done
MNIP4=$(sed -n '4p' < ip.tmp)
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
echo "masterNode4 : true" >> /usr/local/nullentrydev/xgs.log
echo "walletVersion4 : 1.4.0COINVERSION=1.6.0" >> /usr/local/nullentrydev/xgs.log
echo "scriptVersion4 : 0.9d" >> /usr/local/nullentrydev/xgs.log
sleep 3
echo -e "${GREEN}Haulting and Replicating First GenesisX Node${CLEAR}"
genesisx-cli -datadir=/home/genesisx/.genesisx stop
sleep 10
sudo cp -r /home/genesisx/.genesisx/* /home/genesisx4/.genesisx
sleep 5
echo -e ${YELLOW}"Launching First XGS Node"${CLEAR}
genesisxd -datadir=/home/genesisx/.genesisx -daemon
rm /home/genesisx4/.genesisx/genesisx.conf
cp -r /home/genesisx4/genesisx.conf /home/genesisx4/.genesisx/genesisx.conf
echo -e ${YELLOW}"Launching First XGS Node"${CLEAR}
genesisxd -datadir=/home/genesisx/.genesisx -daemon
echo -e ${YELLOW}"Launching Fourth XGS Node"${CLEAR}
genesisxd -datadir=/home/genesisx4/.genesisx -daemon
echo -e "${BOLD} Masternode - \#4 IP: [${MNIP4}]:5555${CLEAR}"
