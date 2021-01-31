#!/bin/bash

RG=$1
RG=${RG:-RG-DE-WC-AAAS}

echo "Delete resource group $RG"
az group delete --no-wait --name $RG
