#!/bin/bash
#############################################################################
#
# Install GCC
# CentOS7 default is 4.8.5
# Geant4.10.6 needs 4.9.5+
# Randomly chose to upgrade to 7.3.0
#
# Plan for this:
# - Get GCC from sft.cern.ch
#
#############################################################################

export OPTICKS_EXTERNALS="${OPTICKS_EXTERNALS:-${HOME}/opticks_externals}"
# GCC
mkdir -p OPTICKS_EXTERNALS/gcc
cd OPTICKS_EXTERNALS/gcc
wget http://ftp.mirrorservice.org/sites/sourceware.org/pub/gcc/releases/gcc-7.3.0/gcc-7.3.0.tar.gz
tar zxf gcc-7.3.0.tar.gz
cd gcc-7.3.0
sudo yum -y install bzip2
./contrib/download_prerequisites
./configure --disable-multilib
make -j 10
sudo make install