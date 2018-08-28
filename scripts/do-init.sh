#!/bin/bash

#all enironment variables and some configs
source do-env.sh
n=0
i=0

echo "Cleaning up directory..."
rm -rf "$outputDir/*"
rm node-env.sh

for node in "${nodes[@]}"
do
   seeds=""
 
   for nodeIP in "${ipAddresses[@]}"
   do
        if (($n!=$i)); then
	    if (( $i < 4 )); then
		seeds="$seeds,$nodeIP:$p2pPort"
	    fi
        fi
        i=$[i+1]      
   done
   n=$[n+1]
   i=0
   seeds="${seeds:1:${#seeds}-1}"
   mkdir -p "$outputDir/$node/config"

   cp "$validatorsDir/priv_validator_$node.json" "$outputDir/$node/config/priv_validator.json"
   cp "$validatorsDir/key_$node.json" "$outputDir/$node/config/key.json"
   cp "$currentDir/data/genesis.json" "$outputDir/$node/config/genesis.json"
   cp "$currentDir/data/config.toml" "$outputDir/$node/config/config.toml"

   sed -i "s/\[CHAIN\-ID\]/$chainID/g" "$outputDir/$node/config/genesis.json" 
   sed -i "s/\[CHAIN\-ID\]/$chainID/g" "$outputDir/$node/config/genesis.json" 
   sed -i "s/\[MONIKER\]/$node/g" "$outputDir/$node/config/config.toml" 
   sed -i "s/\[RPC_PORT\]/$rpcPort/g" "$outputDir/$node/config/config.toml" 
   sed -i "s/\[P2P_PORT\]/$p2pPort/g" "$outputDir/$node/config/config.toml" 
   sed -i "s/\[SEEDS\]/$seeds/g" "$outputDir/$node/config/config.toml"
done

cp "$currentDir/data/node-env.sh" "./"
sed -i "s/\[CHAIN\-ID\]/$chainID/g" "node-env.sh" 

echo "All configuration data have been prepared. ChainID >> "
echo ${chainID}
