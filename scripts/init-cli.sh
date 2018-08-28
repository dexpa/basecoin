#!/bin/bash

source do-env.sh
source node-env.sh

echo "Preparing client: "
basecli init --force-reset --chain-id ${chainID} --node ${ipAddresses[0]}:${rpcPort} && echo "Client Initialized!"
