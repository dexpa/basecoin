#! /bin/bash

#all enironment variables and some configs
source do-env.sh

for ((i=0;i<${#nodes[@]};++i)); do
    printf "Processing node %s with %s\n" "${nodes[i]}" "${ipAddresses[i]}"
    image="/home/ievdokimov/CODE/GoProjects/src/github.com/dexpa/basecoin/scripts/output/${nodes[i]}"
    echo "Removing /root/${nodes[i]} on the host ${nodes[i]}..."
    docker-machine ssh "basecoin-${nodes[i]}" "rm -rf /root/${nodes[i]}"
    echo "Copying from ${image} to host..."
    scp -r ${image} "root@${ipAddresses[i]}:/root" && echo "Transfer completed"
done
