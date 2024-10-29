#!/bin/bash -e

cd /opt
source env.rc

if [ $ARCH = "x86_64" ] ; then

  apt remove -y \
    intel-oneapi-compiler-dpcpp-cpp \
    intel-oneapi-compiler-fortran \
    gcc gfortran

  rm -f /opt/icx.cfg /opt/ifort.cfg
  rm -rf /opt/intel/oneapi/compiler/*/bin/


elif [ $ARCH = "aarch64" ] ; then

  apt remove -y build-essential gcc gfortran libopenblas-dev

else

  exit 1

fi

