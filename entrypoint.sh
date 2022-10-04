#!/bin/sh -l

printenv
time=$(date)
echo "::set-output name=time::$time"