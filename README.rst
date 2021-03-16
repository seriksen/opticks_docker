opticks_docker
==============

Dockerfile for creating docker images for use with Opticks GPU simulations.
Currently it's just an extention of `optix_docker <https://github.com/seriksen/optix_docker>`_ where
the externals are installed.
The installation of opticks follows the guide `here <https://github.com/seriksen/Opticks_install_guide>`_.

Dockerfile overview
-------------------

Base image: :code:`nvidia/cudagl`

* CentOS 7
* NVidia Cuda 10.2
* NVidia OptiX (6.0.0, 6.5.0, 7.0.0)
* Geant4.10.06.p02

Usage
-----

.. code-block:: sh

    source setup_container.sh
    build-opticks-container
    run-opticks-container

Build args;

* Optix Build Version. Set by :code:`optix=`
* Docker user. Set by :code:`user=`

eg; :code:`build-optix optix=NVIDIA-OptiX-SDK-7.0.0.sh user=sam`


.. todo::
    use optix_docker as base image
