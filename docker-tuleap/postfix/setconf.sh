#!/bin/bash

CONTAINER_NAME=${1}

docker cp ./main.cf $CONTAINER_NAME:/etc/postfix/main.cf