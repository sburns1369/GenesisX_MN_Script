# BitcoinGenX_MN_Script

1 to 12 Masternode Installation Script for GenesisX

This script is for use on fresh installations of Ubuntu 16.04 x64 only; or Ubuntu 16.04 x64 installations that were installed by other Sburns/NullEntry (Github = https://github.com/sburns1369).  All scripts where tested on a Vultr VPS

Shameless Referral link for VPS = https://www.vultr.com/?ref=7846384 = All instances built and tested on VULT $3.5 or $5/monthly servers.

*********  Quick Start - Experienced Users ***************
Copy and paste into your VPS:

bash <(curl -Ls https://raw.githubusercontent.com/sburns1369/GenesisX_MN_Script/master/xgs.sh)

*********  {Incomplete Directions - Need to update} - Experienced Users ***************

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

Type: masternode outputs
   -Match up the Genkey to the TX ID earlier and copy the the TX IDs (First set of numbers) and Index Numbers (Either 1 or a 0, after TX ID) to the notepad file.

Save these with a notepad

Connect to your Linux VPS as root

Copy and Paste the command below
bash <(curl -Ls https://raw.githubusercontent.com/sburns1369/GenesisX_MN_Script/master/xgs.sh)



Need help? Have a suggestion? Have a request?
Find Sburns1369#1584 on Discord - https://discord.gg/YhJ8v3g
