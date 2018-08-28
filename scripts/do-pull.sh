#! /bin/bash

#all enironment variables and some configs
source do-env.sh

#overriding
#declare -a nodes=("alpha" "beta" "gamma")

for node in "${nodes[@]}"
do
    #docker-machine ssh "basecoin-${node}" "docker pull ievdokimov/basecoin"
    echo "Pulling into ${node}..."
    eval $(docker-machine env "basecoin-${node}") && echo "Setting Docker Daemon environment..."
    docker pull ${image}
    eval $(docker-machine env -u) && echo "Done"
done



