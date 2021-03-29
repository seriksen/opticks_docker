#!/bin/bash

sudo yum install -y \
      ansible \
      autoconf \
      automake \
      emacs \
      expat-devel \
      git \
      glibc-devel \
      libpng-devel \
      libSM-devel \
      libtool \
      libunwind-devel \
      libXext-devel \
      libXmu-devel \
      make \
      man \
      mesa-libGLU-devel \
      openmotif-devel \
      patch \
      python-devel \
      qt5-qtbase-devel \
      qt5-qtscript-devel \
      wget \
      which \
      sudo \
      zlib-devel

sudo yum install -y https://ecsft.cern.ch/dist/cvmfs/cvmfs-release/cvmfs-release-latest.noarch.rpm
sudo yum install -y cvmfs cvmfs-config-default

echo 'CVMFS_REPOSITORIES=sft.cern.ch,lz.opensciencegrid.org' | sudo tee /etc/cvmfs/default.d/99-lz.conf > /dev/null
echo '/cvmfs	program:/etc/auto.cvmfs' | sudo tee --append /etc/auto.master.d/cvmfs.conf > /dev/null
echo 'CVMFS_HTTP_PROXY="DIRECT"' | sudo tee --append /etc/cvmfs/default.d/99-proxy.conf > /dev/null
sudo systemctl disable autofs
sudo mkdir -p /cvmfs/sft.cern.ch /cvmfs/lz.opensciencegrid.org
echo 'lz.opensciencegrid.org /cvmfs/lz.opensciencegrid.org cvmfs defaults 0 0' | sudo tee --append /etc/fstab > /dev/null
echo 'sft.cern.ch /cvmfs/sft.cern.ch cvmfs defaults 0 0' | sudo tee --append /etc/fstab > /dev/null
sudo mount /cvmfs/sft.cern.ch
sudo mount /cvmfs/lz.opensciencegrid.org
sudo service autofs stop

echo "source /cvmfs/lz.opensciencegrid.org/external/gcc/8.2.0/x86_64-centos7/setup.sh" >> .bashrc
