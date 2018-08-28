#!/bin/bash

START=1
END=100
FROM="reserve_test"
TO="cli_test"

FROM_ADDR=$(basecli keys get ${FROM}  | awk '{print $2}')
declare -a TESTADDR=($(basecli keys list | grep 'testkey' | awk '{print $2}'))

seq=$(./basecli query account ${FROM_ADDR} |  jq -r '.data' | jq -r '.sequence') &&  echo ""
echo "Loading test addresses with colored coins"
echo ""
for ADDR in "${TESTADDR[@]}"
do
    echo ${ADDR}
    echo "REDS >> 1000"
    (./basecli tx send --name=${FROM} --amount="100000CLR red" --to=${ADDR} --sequence=$((seq+1))) < passphrase.dat | tee tx_send.log
    echo "GREEN >> 1000"
    (./basecli tx send --name=${FROM} --amount="100000CLR green" --to=${ADDR} --sequence=$((seq+2))) < passphrase.dat | tee tx_send.log
    echo "BLUE >> 1000"
    (./basecli tx send --name=${FROM} --amount="100000CLR blue" --to=${ADDR} --sequence=$((seq+3))) < passphrase.dat | tee tx_send.log
    seq=$((seq+3))
done

echo "Transactions processed!"
