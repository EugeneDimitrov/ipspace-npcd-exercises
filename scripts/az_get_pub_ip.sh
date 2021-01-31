#!/bin/bash

RG=$2
RG=${RG:-RG-DE-WC-AAAS}

echo "Get public IP for $1 in resource group $RG"
IP=`az vm show -d -g $RG -n $1 --query publicIps|tr -d '"'`

echo "Set public IP for SRV var to" $IP
export SRV_IP=$IP
export SRV_NAME=$1

