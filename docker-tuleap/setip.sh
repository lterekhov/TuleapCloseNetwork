#!/bin/bash

FIND_IP=${1}
REPLACE_IP=${2}

find ./repos/ -name '*.repo' | xargs sed -i "s/$FIND_IP/$REPLACE_IP/"