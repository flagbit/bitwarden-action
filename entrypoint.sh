#!/bin/sh -l

export BW_CLIENTID=$INPUT_BW_CLIENTID
export BW_CLIENTSECRET=$INPUT_BW_CLIENTSECRET
printenv
bw login --apikey
time=$(date)
echo "::set-output name=time::$time"