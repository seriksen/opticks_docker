FROM nvidia/cudagl:10.2-devel-centos7

# Setup
RUN yum -y update
RUN yum -y install sudo

# Optix
ARG optix=NVIDIA-OptiX-SDK-6.0.0-linux64-25650775.sh
ENV OptixInstallScript=${optix}

# Set bash
SHELL ["/bin/bash", "-c"]

# Set user
ARG user=sam
ENV DOCKER_USER="${user}"
RUN useradd -ms /bin/bash --groups wheel ${DOCKER_USER}
RUN echo "${DOCKER_USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER $DOCKER_USER
WORKDIR /home/${DOCKER_USER}

# Standard dependencies
RUN sudo -n yum -y install xorg-x11-apps.x86_64 \
                           xauth \
                           pciutils \
                           lshw \
                           epel-release \
                           wget \
                           zip \
                           unzip \
                           git \
                           libXcursor-devel \
                           libXinerama-devel \
                           libXrandr-devel \
                           mesa-dri-drivers \
                           mesa-libGLES \
                           mesa-libGLw \
                           mesa-libGLw-devel \
                           freeglut-devel \
                           freeglut \
                           expat-devel \
                           doxygen \
                           libXmu-devel \
                           libXi-devel \
                           libGL-devel \
                           libGLU-devel \
                           curl-devel \
                           openssl-devel

# Virtual GL and TurboVNC and Desktop
RUN sudo yum -y install https://downloads.sourceforge.net/project/virtualgl/2.6.3/VirtualGL-2.6.3.x86_64.rpm \
                        lightgdm \
                        https://downloads.sourceforge.net/project/turbovnc/2.2.4/turbovnc-2.2.4.x86_64.rpm

RUN sudo yum -y groupinstall "X Window System" \
                             "Xfce"

# Nvidia OptiX
COPY optix_install_scripts/${OptixInstallScript} /home/${DOCKER_USER}
RUN cd /home/${DOCKER_USER} && yes | bash ${OptixInstallScript}

# Add .bashrc options
COPY scripts/bashrc_customisation.sh /home/${DOCKER_USER}/.bashrc_customisation.sh
RUN cd && echo "source ${HOME}/.bashrc_customisation.sh" >> .bashrc

COPY scripts/opticks_externals_installer.sh /home/${DOCKER_USER}
COPY scripts/geant4_installer.sh /home/${DOCKER_USER}
RUN cd /home/${DOCKER_USER} \
    && export OPTICKS_EXTERNALS=/home/${DOCKER_USER}/opticks_externals \
    && bash opticks_externals_installer.sh


