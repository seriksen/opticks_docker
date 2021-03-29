#!/bin/bash
#################################################################
# Author: Sam Eriksen
#
# Creation Date: March 2021
#
# Script: opticks_docker.sh
#
# Description: Create or run docker container for opticks
#              Note: it does not have opticks in it, but does have
#              all of the externals needed.
#
##################################################################

container-name(){

  if [ ${local_build} -eq 0 ]
  then
    echo "opticks_docker:${optix_version}"
  else
    echo "sameriksen/opticks_docker:${optix_version}"
  fi
}

get_optix_file_name(){

  local optix_file
  if [[ ${optix_version} == 6.0.0 ]]
  then
    optix_file="NVIDIA-OptiX-SDK-6.0.0-linux64-25650775.sh"
  elif [[ ${optix_version} == 6.5.0 ]]
  then
    optix_file="NVIDIA-OptiX-SDK-6.5.0-linux64.sh"
  elif [[ ${optix_version} == 7.0.0 ]]
  then
    optix_file="NVIDIA-OptiX-SDK-7.0.0-linux64.sh"
  else
    optix_file="OptiX version not included yet. Options are 6.0.0, 6.5.0, 7.0.0"
    exit 1
  fi
  # Check if OptiX can be found
  if [ ! -f "optix_install_scripts/${optix_file}" ]
  then
    echo "optix_install_scripts/${optix_file} NOT FOUND"
    echo "Exiting..."
    #exit 1
  fi
  echo "${optix_file}"
}

build-opticks() {
  if [ "${build_container}" -eq 0 ]
  then
    return
  fi

  docker build --no-cache=true \
  -t $(container-name) \
  --build-arg "optix=$(get_optix_file_name)" \
  --build-arg "user=${docker_user}" .
}

run-opticks() {
  if [ "${run_container}" -eq 0 ]
  then
    return
  fi

  # Get optiX libraries
  #centos_search_loc=/usr/lib64/*
  optix_libs=$(find ${search_loc} | grep -i optix)
  rt_libs=$(find ${search_loc} | grep -i rtcore)
  swrast_dri=$(find ${search_loc} | grep -i swrast )

  optix_mounts=""
  for vol in $optix_libs $rt_libs $swrast_dri
  do
  optix_mounts="$optix_mounts -v ${vol}:${vol}"
  done

  # Start the container
  docker run -it \
  --runtime=nvidia \
  --name=$(container-name) \
  --gpus 1 \
  --security-opt seccomp=unconfined \
  --init \
  --net=host \
  --rm=true \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /etc/localtime:/etc/localtime:ro \
  --cap-add SYS_ADMIN --device /dev/fuse \
  ${optix_mounts} \
  $(container-name)
}

print_usage()
{
cat <<EOF
opticks_docker.sh [arguments]

This script is for building and running a docker container for Opticks.
For more information, see github;
https://github.com/seriksen/opticks_docker
Docker containers can be found on dockerhub at;
https://hub.docker.com/repository/docker/sameriksen/opticks_docker

-b Set to 1 to build the container. Set to zero to not. Default is 0
-r Set to 1 to run the container. Set to zero to not. Default is 0
-o OptiX version: eg 6.0.0, 6.5.0, 7.0.0. Default is 6.5.0
-d Set to 1 to use dockerhub. Default is 0. Changes container name: sameriksen/opticks_docker to opticks_docker
-s search location for optix libraries on host machine. Default is /usr/lib64/* (centOS7)
-u Name for inside Docker container. Default is sam
-h prints this help text

Sam Eriksen, 2021
EOF
}


parse_args()
{
  if [ $# -eq 0  ];then
    print_usage
    exit
  fi

  while getopts ":b:r:o:d:s:u:h" opt
  do
    case ${opt} in
       b) build_container="${OPTARG}"
         ;;
       r) run_container="${OPTARG}"
         ;;
       o) optix_version="${OPTARG}"
         ;;
       d) docker_hub="${OPTARG}"
         ;;
       s) search_loc="${OPTARG}"
         ;;
       u) docker_user="${OPTARG}"
         ;;
       h) print_usage && exit 0
         ;;
      \?)
       echo "Invalid option: -$OPTARG" >&2
       ;;
     esac
   done
   shift $((OPTIND-1))
}

main() {

  local build_container=0
  local run_container=0
  local optix_version=6.5.0
  local docker_hub=0
  local search_loc="/usr/lib64/*"
  local docker_user="sam"
  parse_args "$@"

  build-opticks
  run-opticks

}

main "$@"



