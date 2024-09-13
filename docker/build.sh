#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd $DIR

docker build -f $DIR/Dockerfile -t ros2_spot:latest ..


#docker build --no-cache -f $DIR/Dockerfile -t blueboat_sitl_x:latest ..
