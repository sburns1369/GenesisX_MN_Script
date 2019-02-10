# GenesisX_MN_Script
Installation Script for Installing up to 4 GenesisX Masternodes (XGS Version 1.4.0)

This script is for use on fresh installations of Ubuntu 16.04 x64 only; or Ubuntu 16.04 x64 installations that were installed by other Sburns/NullEntry (Github = https://github.com/sburns1369).  All scripts where tested on a Vultr VPS

Shameless Referral link = https://www.vultr.com/?ref=7846384

*********  Quick Start - Experienced Users ***************

Copy and Paste:

bash <(curl -Ls https://raw.githubusercontent.com/sburns1369/GenesisX_MN_Script/master/xgs.sh)

Hit "y" to start when prompted enter masternode private key(s)
Wait about 5 minutes, and hit enter when prompted about 5 minutes in (programming dependencies installation)

Sync time is around 3 hours for one masternodes
Sync time was over 10 hours for all four.

Check MN 1
genesisx-cli -datadir=/home/genesisx/.genesisx mnsync status
Check MN 2
genesisx-cli -datadir=/home/genesisx2/.genesisx mnsync status
Check MN 3
genesisx-cli -datadir=/home/genesisx3/.genesisx mnsync status
Check MN 4
genesisx-cli -datadir=/home/genesisx4/.genesisx mnsync status

**********  Full Set Up **********

Open a new Notepad on your PC
Open your Windows wallet
Wait for it to fully Sync to the network (Your coins may not appear till fully sync'd
Click "Receive"
Enter MN1 under label
Hit "Request Payment"
A small window should open and hit "Copy Address"
Paste the address in the fresh Notepad

***Repeat that process 4 times, if making 4 masternodes, I suggest MN2, MN3, MN4 for logical reasons as label) ***

Now send the collateral of exactly 5000 coins, do not include transmission cost in the send amount
  -it will be automatically deducted.
Wait for each transaction to have 6 confirmations.
  -you can hold your cursor over the transactions under "transactions" to see number of confirms

Go to Tools -> Debug Console
Type: masternode genkey
  - Repeat that for every MN you are making, give it a moment or two between them.

Type: masternode outputs
   -Match up the Genkey to the TX ID earlier and copy the the TX IDs (First set of numbers) and Index Numbers (Either 1 or a 0, after TX ID) to the notepad file.

Save these with a notepad

Connect to your Linux VPS as root

Copy and Paste the command below
bash <(curl -Ls https://raw.githubusercontent.com/sburns1369/GenesisX_MN_Script/master/xgs.sh)

Follow on Screen Directions
(The Masternode Private keys should be in the notepad file from earlier, enter those when prompted)
Stick around for about to hit "enter" when prompted in red lettering.
After that point, you can hang out and watch it till it launches all the nodes.
Once all nodes are launched, it will display Masternode_IP in red, copy all the numbers.
(Example,  Masternode_IP: 155.138.161.248:5555)
(So copy 155.138.161.248:5555)
Put the copied numbers in the notepad file you made earlier.
It will around 2 hours roughly for it to fully sync.
  -Longer if you are doing more nodes.
While we wait we can configure the Windows Wallet.
Go back to (or open) your windows wallet.
Click on "Tools"
Select "Masternode Configuration File" from the lsit.
In the Notepad that Opens titled "masternode.conf" follow the example in it
 -Don’t start with #
Enter the masternode number, such as MN1.
Than the Masternode_IP from earlier, 155.138.161.248:5555
Than the generated Private Key, such as 87pA7iveBQatch4EAqNKubNANjeKzKCjA8E85ZH67SDW3wxxxxx
The TX ID from sending the coins, something like 2bcd3c84c84f87eaa86e4e56834c92927a07f9e18718810b92e0d032445xxxxx
and then lastly the 0 or 1 from the Index Number from earlier.
Hit enter, and enter the information for the next Masternode, if your entering more than 1.
Once complete, save the file.
Close the Wallet
 -Make sure you close it, not just minimize it.
Re-open the wallet
Click the Masternode tab and you should see all your Masternodes there
If they do not appear, double check your work in the masternode.conf
go back to your VPS and occasionally check the Masternodes Sync'ing status with the commands...

To Check MN 1
genesisx-cli -datadir=/home/genesisx/.genesisx mnsync status
To Check MN 2
genesisx-cli -datadir=/home/genesisx2/.genesisx mnsync status
To Check MN 3
genesisx-cli -datadir=/home/genesisx3/.genesisx mnsync status
To Check MN 4
genesisx-cli -datadir=/home/genesisx4/.genesisx mnsync status

We are watching for the "IsBlockchainSynced" to equals true, not false.
This will take some time, relax.
Once  "IsBlockchainSynced" : true
Go back to the Wallet and hit "Start all"
It may take around another 15 to 20 minutes, or even instantly to activate the Masternode.

You can check the status of your masternodes with the commands below

To Check MN 1
genesisx-cli -datadir=/home/genesisx/.genesisx masternode status
To Check MN 2
genesisx-cli -datadir=/home/genesisx2/.genesisx masternode status
To Check MN 3
genesisx-cli -datadir=/home/genesisx3/.genesisx masternode status
To Check MN 4
genesisx-cli -datadir=/home/genesisx4/.genesisx masternode status

Need help? Have a suggestion? Have a request?
Find Sburns1369#1584 on Discord - https://discord.gg/YhJ8v3g
Website will hopefully by up early March 2019

Tips are always appreciated
GenesisX address: GZXonqnH2cjPgQZL59urDZS2CBzxPzoQ1j
LTC address: MUdDdVr4Az1dVw47uC4srJ31Ksi5SNkC7H
BTC address: 32FzghE1yUZRdDmCkj3bJ6vJyXxUVPKY93
