#!/bin/bash


RESERVE="reserve_test"
TEST1="cli_test"
TEST2="testkey99"

RESER_ADDR=$(./basecli keys get ${RESERVE}  | awk '{print $2}')
TEST1_ADDR=$(./basecli keys get ${TEST1}  | awk '{print $2}')
TEST2_ADDR=$(./basecli keys get ${TEST2} | awk '{print $2}')

SEQR=$(./basecli query account ${RESER_ADDR} |  jq -r '.data' | jq -r '.sequence')
SEQT1=$(./basecli query account ${TEST1_ADDR} |  jq -r '.data' | jq -r '.sequence')
SEQT2=$(./basecli query account ${TEST2_ADDR} |  jq -r '.data' | jq -r '.sequence')

echo "State"

AMT0=$(./basecli query account ${RESER_ADDR} | jq -r '.data' | jq -r '.coins' | jq -r '.[0].amount')
AMT1=$(./basecli query account ${TEST1_ADDR} | jq -r '.data' | jq -r '.coins' | jq -r '.[0].amount')
AMT2=$(./basecli query account ${TEST2_ADDR} | jq -r '.data' | jq -r '.coins' | jq -r '.[0].amount')
TAG1=$(./basecli query account ${TEST1_ADDR} | jq -r '.data' | jq -r '.coins' | jq -r '.[0].tag')
TAG2=$(./basecli query account ${TEST2_ADDR} | jq -r '.data' | jq -r '.coins' | jq -r '.[0].tag')

AMT1_2=$(./basecli query account ${TEST1_ADDR} | jq -r '.data' | jq -r '.coins' | jq -r '.[1].amount')
AMT2_2=$(./basecli query account ${TEST2_ADDR} | jq -r '.data' | jq -r '.coins' | jq -r '.[1].amount')
TAG1_2=$(./basecli query account ${TEST1_ADDR} | jq -r '.data' | jq -r '.coins' | jq -r '.[1].tag')
TAG2_2=$(./basecli query account ${TEST2_ADDR} | jq -r '.data' | jq -r '.coins' | jq -r '.[1].tag')

printf "Reserve ${AMT0},\n\tTest1 ${AMT1} ${TAG1}, ${AMT1_2} ${TAG1_2},\n\tTest2 ${AMT2} ${TAG2}, ${AMT2_2} ${TAG2_2}\n"
printf "Sum $((AMT0+AMT1+AMT2+AMT1_2+AMT2_2))\n"

echo "Step one -- sending using RESERVE CLIENT"

(./baseclir tx send --name=${RESERVE} --amount="1000CLR x" --to=${TEST1_ADDR} --sequence=$((SEQR+1))) < passphrase.dat 
(./baseclir tx send --name=${RESERVE} --amount="1000CLR x" --to=${TEST2_ADDR} --sequence=$((SEQR+2))) < passphrase.dat 

AMT0=$(./basecli query account ${RESER_ADDR} | jq -r '.data' | jq -r '.coins' | jq -r '.[0].amount')
AMT1=$(./basecli query account ${TEST1_ADDR} | jq -r '.data' | jq -r '.coins' | jq -r '.[0].amount')
AMT2=$(./basecli query account ${TEST2_ADDR} | jq -r '.data' | jq -r '.coins' | jq -r '.[0].amount')
TAG1=$(./basecli query account ${TEST1_ADDR} | jq -r '.data' | jq -r '.coins' | jq -r '.[0].tag')
TAG2=$(./basecli query account ${TEST2_ADDR} | jq -r '.data' | jq -r '.coins' | jq -r '.[0].tag')

AMT1_2=$(./basecli query account ${TEST1_ADDR} | jq -r '.data' | jq -r '.coins' | jq -r '.[1].amount')
AMT2_2=$(./basecli query account ${TEST2_ADDR} | jq -r '.data' | jq -r '.coins' | jq -r '.[1].amount')
TAG1_2=$(./basecli query account ${TEST1_ADDR} | jq -r '.data' | jq -r '.coins' | jq -r '.[1].tag')
TAG2_2=$(./basecli query account ${TEST2_ADDR} | jq -r '.data' | jq -r '.coins' | jq -r '.[1].tag')

printf "Reserve ${AMT0},\n\tTest1 ${AMT1} ${TAG1}, ${AMT1_2} ${TAG1_2},\n\tTest2 ${AMT2} ${TAG2}, ${AMT2_2} ${TAG2_2}\n"
printf "Sum $((AMT0+AMT1+AMT2+AMT1_2+AMT2_2))\n"

echo "Step two"
(./basecli tx send --name=${TEST1} --amount="100CLR 7d33ac" --to=${TEST2_ADDR} --sequence=$((SEQT1+1))) < passphrase.dat 
(./basecli tx send --name=${TEST2} --amount="100CLR 58e45a" --to=${TEST1_ADDR} --sequence=$((SEQT2+1))) < passphrase.dat 

AMT0=$(./basecli query account ${RESER_ADDR} | jq -r '.data' | jq -r '.coins' | jq -r '.[0].amount')
AMT1=$(./basecli query account ${TEST1_ADDR} | jq -r '.data' | jq -r '.coins' | jq -r '.[0].amount')
AMT2=$(./basecli query account ${TEST2_ADDR} | jq -r '.data' | jq -r '.coins' | jq -r '.[0].amount')
TAG1=$(./basecli query account ${TEST1_ADDR} | jq -r '.data' | jq -r '.coins' | jq -r '.[0].tag')
TAG2=$(./basecli query account ${TEST2_ADDR} | jq -r '.data' | jq -r '.coins' | jq -r '.[0].tag')

AMT1_2=$(./basecli query account ${TEST1_ADDR} | jq -r '.data' | jq -r '.coins' | jq -r '.[1].amount')
AMT2_2=$(./basecli query account ${TEST2_ADDR} | jq -r '.data' | jq -r '.coins' | jq -r '.[1].amount')
TAG1_2=$(./basecli query account ${TEST1_ADDR} | jq -r '.data' | jq -r '.coins' | jq -r '.[1].tag')
TAG2_2=$(./basecli query account ${TEST2_ADDR} | jq -r '.data' | jq -r '.coins' | jq -r '.[1].tag')

printf "Reserve ${AMT0},\n\tTest1 ${AMT1} ${TAG1}, ${AMT1_2} ${TAG1_2},\n\tTest2 ${AMT2} ${TAG2}, ${AMT2_2} ${TAG2_2}\n"
printf "Sum $((AMT0+AMT1+AMT2+AMT1_2+AMT2_2))\n"

echo "Step three"

(./basecli tx send --name=${TEST1} --amount="100CLR 58e45a" --to=${RESER_ADDR} --sequence=$((SEQT1+2))) < passphrase.dat 
(./basecli tx send --name=${TEST2} --amount="100CLR 7d33ac" --to=${RESER_ADDR} --sequence=$((SEQT2+2))) < passphrase.dat 


AMT0=$(./basecli query account ${RESER_ADDR} | jq -r '.data' | jq -r '.coins' | jq -r '.[0].amount')
AMT1=$(./basecli query account ${TEST1_ADDR} | jq -r '.data' | jq -r '.coins' | jq -r '.[0].amount')
AMT2=$(./basecli query account ${TEST2_ADDR} | jq -r '.data' | jq -r '.coins' | jq -r '.[0].amount')
TAG1=$(./basecli query account ${TEST1_ADDR} | jq -r '.data' | jq -r '.coins' | jq -r '.[0].tag')
TAG2=$(./basecli query account ${TEST2_ADDR} | jq -r '.data' | jq -r '.coins' | jq -r '.[0].tag')

AMT1_2=$(./basecli query account ${TEST1_ADDR} | jq -r '.data' | jq -r '.coins' | jq -r '.[1].amount')
AMT2_2=$(./basecli query account ${TEST2_ADDR} | jq -r '.data' | jq -r '.coins' | jq -r '.[1].amount')
TAG1_2=$(./basecli query account ${TEST1_ADDR} | jq -r '.data' | jq -r '.coins' | jq -r '.[1].tag')
TAG2_2=$(./basecli query account ${TEST2_ADDR} | jq -r '.data' | jq -r '.coins' | jq -r '.[1].tag')

printf "Reserve ${AMT0},\n\tTest1 ${AMT1} ${TAG1}, ${AMT1_2} ${TAG1_2},\n\tTest2 ${AMT2} ${TAG2}, ${AMT2_2} ${TAG2_2}\n"
printf "Sum $((AMT0+AMT1+AMT2+AMT1_2+AMT2_2))\n"
echo "Test is complete"
