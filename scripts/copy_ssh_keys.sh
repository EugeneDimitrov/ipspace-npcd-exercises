#!/bin/bash

echo "Copy ssh keys to" $SRV_NAME
scp ~/.ssh/id_rsa azure@$SRV_IP:.ssh/