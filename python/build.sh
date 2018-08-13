#!/bin/bash
#git clone https://github.com/docker-library/python.git

python_docker_git_url="https://github.com/docker-library/python.git"
default_version="2.7"
default_baseimage="alpine3.7"
git_dir="git_python"
version=${1:-$default_version}
baseimage=${2:-$default_baseimage}
python_docker_path=$git_dir/${version}/${baseimage}/Dockerfile
docker_file="Dockerfile"

[ -d $git_dir ] || git clone $python_docker_git_url $git_dir
[ -d $git_dir/.git ] && git -C $git_dir reset --hard  && git -C $git_dir pull

if [ ! -f $python_docker_path ];then
    echo "cannot finde $python_docker_path"
    exit 1
fi

[ -h $docker_file ] && rm $docker_file
ln -s $python_docker_path $docker_file

#sed -e 's|^CMD|#CMD|' $docker_file

docker build --force-rm --rm -t python:$version .
