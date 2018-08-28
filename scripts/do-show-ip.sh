#! /bin/bash

#all enironment variables and some configs
source do-env.sh

for node in "${nodes[@]}"
do
    echo $(docker-machine ip "basecoin-${node}")
done



