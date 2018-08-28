#! /bin/bash

#all enironment variables and some configs
source do-env.sh

for node in "${nodes[@]}"
do
    docker-machine start "basecoin-${node}"
done



