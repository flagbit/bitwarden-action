#!/bin/sh -l

export BW_CLIENTID=$INPUT_BW_CLIENTID
export BW_CLIENTSECRET=$INPUT_BW_CLIENTSECRET
bw login --apikey --quiet
export BW_SESSION=$(bw unlock --raw --passwordenv INPUT_BW_PASSWORD)

COLLECTION_NAME=customer/foodspring

COLLECTION_ID=$(bw list collections | jq --raw-output '.[] | select(.name=="'$COLLECTION_NAME'") | .id')
echo $COLLECTION_ID
time=$(date)


echo "::set-output name=time::$time"