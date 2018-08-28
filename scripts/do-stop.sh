#! /bin/bash

#all enironment variables and some configs
source do-env.sh

declare -a stopNodes=("beta" "gamma" "delta" "epsilon" "zeta" "eta" "theta" "iota")

for node in "${stopNodes[@]}"
do
    docker-machine stop "basecoin-${node}"
done



