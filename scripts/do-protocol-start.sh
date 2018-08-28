#!/bin/bash

#all enironment variables and some configs
source node-env.sh

for node in "${nodes[@]}"
do
    echo "Setting Docker Daemon environment for ${node}..."
    eval $(docker-machine env "basecoin-${node}") && echo "Ok. Proceed..."
    docker run --net host --name ${node} -d -v "$basecoinDir/$node/config":"/basecoin" ${image} start --trace #--log_level info
    eval $(docker-machine env -u) && echo "Done"
done
