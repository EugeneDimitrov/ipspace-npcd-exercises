#!/bin/bash

RG=$1
RG=${RG:-RG-DE-WC-AAAS}
SUB="d23ffeda-4d68-496a-a0b0-1abb8b4aa902"

echo "Delete resource group $RG"
az group delete --no-wait --subscription $SUB --name $RG
