**************
Opticks Docker
**************
Repository containing the Dockerfile and bash scripts needed to create a docker image which has all of the externals
needed for `Opticks <https://bitbucket.org/SamEriksen/opticks/src/master/>`_.

Usage
=====

1. Download NVidia OptiX and put in the optix_install_scripts directory.
2. run :code:`./opticks_docker.sh -h` to get all options on running/building container

To run container from dockerhub: :code:`./opticks_docker.sh -r 1 -o 6.5.0 -d 1`

Starting visualisation
----------------------
To start visualisation, run :code:`start_desktop`.
This will ask you to set a password and output the address to connect to.

To kill the vnc server, type :code:`kill_desktop`.

To see what these do, look in :code:`scripts/bashrc_customisation.sh`

Dockerhub
---------
Images can be found on `dockerhub <https://hub.docker.com/r/sameriksen/opticks_docker>`_


Systems tested on
=================

* Bristol HEP GPU01
   - Tesla T4 (x6)