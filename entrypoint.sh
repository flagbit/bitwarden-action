#!/bin/sh -l

export BW_CLIENTID=$INPUT_BW_CLIENTID
export BW_CLIENTSECRET=$INPUT_BW_CLIENTSECRET
bw login --apikey --quiet
export BW_SESSION=$(bw unlock --raw --passwordenv INPUT_BW_PASSWORD)

# export INPUT_SECRETS="customer/foodspring | COMPOSER_AUTH | notes | COMPOSER_AUTH
# customer/foodspring | SSH_KNOWN_HOSTS | notes | SSH_KNOWN_HOSTS"

IFS='
'

for line in $INPUT_SECRETS
do
    COLLECTION_NAME=$(echo $line | cut -d"|" -f1 | sed 's/ *$//g' | sed 's/^ *//g')
    ITEM_NAME=$(echo $line | cut -d"|" -f2 | sed 's/ *$//g' | sed 's/^ *//g')
    ITEM_TYPE=$(echo $line | cut -d"|" -f3 | sed 's/ *$//g' | sed 's/^ *//g')
    ENV_VAR_NAME=$(echo $line | cut -d"|" -f4 | sed 's/ *$//g' | sed 's/^ *//g')

    COLLECTION_ID=$(bw list collections | jq --raw-output '.[] | select(.name=="'$COLLECTION_NAME'") | .id')
    SECRET_VALUE=$(bw list items | jq --raw-output '.[] | select( .collectionIds | index("'$COLLECTION_ID'") ) | select ( .name=="'$ITEM_NAME'" ) | .'$ITEM_TYPE'')

    DELIMITER=$(cat /proc/sys/kernel/random/uuid | sed 's/[-]//g' | head -c 20; echo;)

    # set as multiline environemnt variable
    echo "$ENV_VAR_NAME<<$DELIMITER" >> $GITHUB_ENV
    echo "$SECRET_VALUE" >> $GITHUB_ENV
    echo "$DELIMITER" >> $GITHUB_ENV

    # make sure that all lines of the secret are masked in github-actions
    echo "$SECRET_VALUE" | while read -r line;
    do
        echo "::add-mask::${line}"
    done
done