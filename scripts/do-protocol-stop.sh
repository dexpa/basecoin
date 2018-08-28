#!/bin/bash

source node-env.sh

for node in "${nodes[@]}"
do
    echo "Setting Docker Daemon environment for ${node}..."
    eval $(docker-machine env "basecoin-${node}") && echo "Ok. Proceed..."
    docker stop ${node} && echo "stopped. Cleaning and unsetting environment..."
    docker rm ${node}
    eval $(docker-machine env -u) && echo "Done!"
done
