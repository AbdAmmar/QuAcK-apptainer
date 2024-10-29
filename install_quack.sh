#!/bin/bash -e

cd /opt
source env.rc

APT_REQUIRED="" #"bash"
APT_NOT_REQUIRED="git make ninja-build"

apt install -y $APT_REQUIRED $APT_NOT_REQUIRED

git clone https://github.com/pfloos/QuAcK.git \
    --branch=work_env --depth=1 --shallow-submodules


cd /opt/QuAcK
#if [ $ARCH = x86_64 ] ; then
#  apt remove -y gfortran  # Conflict with omp_lib
#fi
make

# Test
ls /opt/QuAcK/bin/QuAcK || exit 1

apt remove -y $APT_NOT_REQUIRED

