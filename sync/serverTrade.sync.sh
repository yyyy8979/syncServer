#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
varPath="$DIR/function/var.sh"
if [ -f $varPath ];then source $varPath;
else echo "source var.sh failed!";exit;fi

sync_var(){
sed -i "s/^thisServerIp=.*$/thisServerIp=10.0.0.3/g" $varPath
sed -i "s/^thisServerPort=.*$/thisServerPort=25565/g" $varPath

#sed -i "s/^thisWorldName=.*$/thisWorldName=\"trade\"/g" $varPath
#sed -i "s/^thisWorldName=.*$/thisWorldName=\"Qwhite\"/g" $varPath
sed -i "s/^thisWorldName=.*$/thisWorldName=\"moha\"/g" $varPath

sed -i 's/^session=.*$/session=mc3/g' $varPath
sed -i 's/^window=.*$/window=1/g' $varPath
sed -i 's/^pane=.*$/pane=0/g' $varPath
}
sync_conf(){
local to=$thisServerPath/server.properties
sed -i "s/^level-name=$/level-name=$thisWorldName/g" $to
sed -i "s/^server-port=$/server-port=$thisServerPort/g" $to
sed -i "s/^server-name=$/server-name=up9cloud - $thisWorldName/g" $to
sed -i 's/^enable-command-block=.*$/enable-command-block=true/g' $to

#sed -i 's/^spawn-animals=.*$/spawn-animals=true/g' $to
#sed -i 's/^spawn-monsters=.*$/spawn-monsters=true/g' $to
#sed -i 's/^spawn-npcs=.*$/spawn-npcs=true/g' $to

sed -i 's/^gamemode=.*$/gamemode=1/g' $to

sed -i 's/^max-players=.*$/max-players=5/g' $to
sed -i 's/^spawn-protection=.*$/spawn-protection=100000/g' $to

sed -i 's/^white-list=.*$/white-list=true/g' $to
}
sync_start(){
local to=$thisServerPath/start.sh
sed -i 's/^local Xms=.*$/Xms=64M/g' $to
sed -i 's/^local Xmx=.*$/Xmx=512M/g' $to
}
sync_op(){
local to=$thisServerPath/ops.txt
echo "sp-bonebonekai" >> $to
echo "O0oO0o0Oo0O" >> $to
}
sync_var;
source_all;

purge_plugins all;

msg_startSync;
scp_getControllers;
sync_start;
scp_getServer spigot;
sync_conf;
sync_op;

scp_getPlugin SuperCensor
scp_getPlugin VariableTriggers;
scp_getPlugin BungeeSuiteWarps;
#scp_getPlugin TeleportSigns;
scp_getPlugin ChatColors;
scp_getPlugin PermissionsEx;
#scp_getPlugin Vault;
#scp_getPlugin iConomy;
#scp_getPlugin WorldBorder;
scp_getPlugin WorldEdit;
scp_getPlugin dynmap;
msg_endSync;
