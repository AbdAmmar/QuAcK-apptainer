#!/bin/bash -e

cd /opt


apt update && apt install -y --no-install-recommends \
  python3-pip \
  python3-dev 
#\
#  build-essential \

pip3 install pyscf


