#!/bin/bash -x
go_docker_git_url="https://github.com/docker-library/golang.git"
default_version="1.10"
default_baseimage="alpine3.7"
git_dir="git_golang"
version=${1:-$default_version}
baseimage=${2:-$default_baseimage}
go_docker_path=golang/${version}/${baseimage}/Dockerfile
docker_file="Dockerfile"

[ -d $git_dir ] || git clone $go_docker_git_url
[ -d $git_dir/.git ] && git -C $git_dir reset --hard  && git -C $git_dir pull

if [ ! -f $go_docker_path ];then
    echo "cannot finde $go_docker_path"
    exit 1
fi

[ -h $docker_file ] && rm $docker_file
ln -s $go_docker_path $docker_file


# sed -e 's|^CMD|#CMD|' $docker_file
# add my user home dir
user=$USER
uid=$(id $USER -u)
gid=$(id $USER -g)
echo "RUN addgroup -g $gid $USER && adduser -D -G $USER -u $uid -h /home/$USER $USER && mkdir -p /home/$USER/work_dir&& chown $USER:$USER -R /home/$USER/work_dir" >> $docker_file
docker build --force-rm --rm -t go:$version .
