#!/bin/bash

#source node-env.sh

tread="$1"
echo "Tread ${tread}"

START=1
END=100000
FROM="testkey${tread}" #"reserve_test"
TO="cli_test"

FROM_ADDR=$(basecli keys get ${FROM}  | awk '{print $2}')
TO_ADDR=$(basecli keys get ${TO} | awk '{print $2}')

SEQ=$(basecli query account ${FROM_ADDR} |  jq -r '.data' | jq -r '.sequence')

for (( c=$START; c<=$END; c++ ))
do
    (basecli tx send --name=${FROM} --amount="1CLR red" --to=${TO_ADDR} --sequence=$((SEQ+1))) < passphrase.dat 
    sleep $(( $RANDOM % 15 ))
    (basecli tx send --name=${FROM} --amount="1CLR green" --to=${TO_ADDR} --sequence=$((SEQ+2))) < passphrase.dat 
    sleep $(( $RANDOM % 15 ))
    (basecli tx send --name=${FROM} --amount="1CLR blue" --to=${TO_ADDR} --sequence=$((SEQ+3))) < passphrase.dat 
    sleep $(( $RANDOM % 15 ))
    SEQ=$((SEQ+3))
done
