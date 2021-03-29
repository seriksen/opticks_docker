#!/bin/bash
#############################################################################
#
# Install Geant4
#
#############################################################################

g4_version=geant4.10.06.p02
dir=${OPTICKS_EXTERNALS}/g4
mkdir -p ${dir}
cd ${dir}
url=http://cern.ch/geant4-data/releases/${g4_version}.tar.gz
curl -L -O $url
tar zxf ${g4_version}.tar.gz
mkdir ${g4_version}-build
cd ${g4_version}-build
cmake -G "Unix Makefiles" \
      -DCMAKE_BUILD_TYPE=Debug \
      -DGEANT4_INSTALL_DATA=ON \
      -DGEANT4_USE_GDML=ON \
      -DGEANT4_USE_SYSTEM_CLHEP=ON \
      -DCLHEP_ROOT_DIR=${OPTICKS_EXTERNALS}/clhep/clhep_${clhep_version}-install \
      -DGEANT4_INSTALL_DATA_TIMEOUT=3000 \
      -DXERCESC_ROOT_DIR=${OPTICKS_EXTERNALS}/xerces/xerces-c-${xerces_version}-install \
      -DCMAKE_INSTALL_PREFIX=${dir}/${g4_version}-install \
      ${dir}/${g4_version}
make -j 10
make install