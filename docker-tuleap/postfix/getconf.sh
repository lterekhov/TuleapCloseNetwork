#!/bin/bash

CONTAINER_NAME=${1}

docker cp $CONTAINER_NAME:/etc/postfix/main.cf ./main.cf