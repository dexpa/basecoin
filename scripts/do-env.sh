#!/bin/bash

export DIGITALOCEAN_ACCESS_TOKEN="04daeb0c125fe56f4b04f2b07294891b214244ecf62c248fe6616acee82e5b35"
export DIGITALOCEAN_SSH_KEY_FINGERPRINT="29:96:09:fd:14:28:6e:fc:93:81:5c:08:39:32:15:6f"
DIGITALOCEAN_IMAGE="centos-7-x64"
export DIGITALOCEAN_REGION="fra1"

currentDir=$(pwd)
validatorsDir="$currentDir/data/validators"
outputDir="$currentDir/output"

chainID=$(openssl rand -hex 8)
p2pPort=30000
rpcPort=30001

declare -a ipAddresses=(165.227.144.195 159.65.114.104 159.89.171.9 209.97.164.13 159.65.117.49 206.81.31.94 206.81.28.243 206.81.18.36 159.89.104.250)

declare -a nodes=("alpha" "beta" "gamma" "delta" "epsilon" "zeta" "eta" "theta" "iota")
image="ievdokimov/basecoin"
