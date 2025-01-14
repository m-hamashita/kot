#!/bin/bash

CONFIG_PATH=${HOME}/.kot/config.yaml
if [ ! -f "$CONFIG_PATH" ]; then
  CONFIG_PATH=${PWD}/config.yaml
fi

if [ $1 == "s" ]; then
  CMD="start"
elif [ $1 == "e" ]; then
  CMD="end"
else
  CMD=$1
fi

echo "Command: $CMD"
if [ $CMD != "start" ] && [ $CMD != "end" ] && [ $CMD != "rest_start" ] && [ $CMD = "rest_end" ]; then
  echo "Error: you need one of the following arguments: 'start', 'end', 'rest_start' or 'rest_end'"
  exit 1
fi

MESSAGE=$2
if [ -z $MESSAGE ]; then
  docker run -it --rm -v ${CONFIG_PATH}:/kot/config.yaml takaiyuk/kot -m kot \
    myrecorder ${CMD} --no-yes --browser-kind chromium
else
  docker run -it --rm -v ${CONFIG_PATH}:/kot/config.yaml takaiyuk/kot -m kot \
    myrecorder ${CMD} --no-yes --message ${MESSAGE} --browser-kind chromium
fi
