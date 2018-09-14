#!/bin/bash

FROM="reserve_test"
TO="cli_test"

FROM_ADDR=$(basecli keys get ${FROM}  | awk '{print $2}')
declare -a TESTADDR=($(basecli keys list | grep 'testkey' | awk '{print $2}'))

seq=$(basecli query account ${FROM_ADDR} |  jq -r '.data' | jq -r '.sequence') &&  echo "Sequence received ${seq}"
echo "Loading test addresses with colored coins"
echo ""
for ADDR in "${TESTADDR[@]}"
do
    echo ${ADDR}
    echo "Some >> 1000"
    (basecli tx send --name=${FROM} --amount="10000000 x" --to=${ADDR} --sequence=$((seq+1))) < passphrase.dat | tee tx_send.log
    seq=$((seq+1))
done

echo "Transactions processed!"
