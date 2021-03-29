opticks_docker
==============

Dockerfile for creating docker images for use with Opticks GPU simulations.
Currently it's just an extention of `optix_docker <https://github.com/seriksen/optix_docker>`_ where
the externals are installed.

You still need to clone and build opticks as descriped in the installation guide
`here <https://github.com/seriksen/Opticks_install_guide>`_.

.. todo::
   Add to dockerfile to build opticks rather than that being an extra step. Though worthwhile having this as the
   'has all externals' version for a future CI.

Dockerfile overview
-------------------

Base image: :code:`nvidia/cudagl`

* CentOS 7
* NVidia Cuda 10.2
* NVidia OptiX (6.0.0, 6.5.0, 7.0.0)
* Geant4.10.06.p02

Usage
-----

Download NVidia OptiX and put in the optix_install_scripts directory.
Then run opticks_docker.sh


Starting visualisation
----------------------
To start visualisation, run :code:`start_desktop`.
This will ask you to set a password and output the address to connect to.

To kill the vnc server, type :code:`kill_desktop`.


Systems tested on
-----------------

* Bristol HEP GPU01
   - Tesla T4 (x6)