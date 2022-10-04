#!/bin/sh -l

export BW_CLIENTID=$INPUT_BW_CLIENTID
export BW_CLIENTSECRET=$INPUT_BW_CLIENTSECRET
bw login --apikey --quiet
export BW_SESSION=$(bw unlock --raw --passwordenv INPUT_BW_PASSWORD)

COLLECTION_NAME=customer/foodspring

COLLECTION_ID=$(bw list collections | jq --raw-output '.[] | select(.name=="'$COLLECTION_NAME'") | .id')
echo $COLLECTION_ID
time=$(date)

export INPUT_SECRETS="customer/foodspring | COMPOSER_AUTH | notes | COMPOSER_AUTH
customer/foodspring | SSH_KNOWN_HOSTS | notes | SSH_KNOWN_HOSTS"

node index.js

echo $INPUT_SECRETS

echo "::set-output name=time::$time"
echo 'BLA=BLUBB' >> $GITHUB_ENV