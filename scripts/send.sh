#!/bin/bash

source node-env.sh+

tread="$1"
echo "Tread ${tread}"

START=1
END=100
FROM=cli_test #"reserve_test"
TO=reserve_test #"cli_test"

FROM_ADDR=$(basecli keys get ${FROM}  | awk '{print $2}')
TO_ADDR=$(basecli keys get ${TO} | awk '{print $2}')

seq=$(basecli query account ${FROM_ADDR} |  jq -r '.data' | jq -r '.sequence')

CS=$((START+seq))
CE=$((END+seq))

for (( c=$CS; c<=$CE; ))
do
    echo "REDS >> 1000"
    (basecli tx send --name=${FROM} --amount=1000red --to=${TO_ADDR} --sequence=${c}) < passphrase.dat | tee ./output/tx_send.log
    echo "GREEN >> 1000"
    (basecli tx send --name=${FROM} --amount=1000green --to=${TO_ADDR} --sequence=$((c+1))) < passphrase.dat | tee ./output/tx_send.log
    echo "BLUE >> 1000"
    (basecli tx send --name=${FROM} --amount=1000blue --to=${TO_ADDR} --sequence=$((c+2))) < passphrase.dat | tee ./output/tx_send.log
    c=$((c+3))
done

echo "Transactions processed!"
