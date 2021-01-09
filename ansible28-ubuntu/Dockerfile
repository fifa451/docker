FROM ubuntu:18.04 AS basic_pkg_build

ARG PKG_NAMES="curl \
    ca-certificates \
    python3 python3-pip python3-setuptools python3-dev \
    openssh-client \
    libffi-dev \
    git \
    build-essential \
    apt-transport-https gnupg-agent software-properties-common"
ARG USERNAME=jenkins
ARG USERID=1000
ARG GROUPID=1000

RUN addgroup \
    --gid ${GROUPID} ${USERNAME} \
    && adduser --gecos --quiet --disabled-password \
    --ingroup ${USERNAME} -uid ${USERID} ${USERNAME}

RUN apt-get update -y \
    && apt-get install ${PKG_NAMES} --no-install-recommends -y \
    && apt-get upgrade -y && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

## build docker daemon
FROM basic_pkg_build AS docker_build
ARG DOCKER_PKGS="docker-ce docker-ce-cli containerd.io"
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add \
    && add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable" \
    && apt-get update \
    && apt-get install ${DOCKER_PKGS} --no-install-recommends -y \
    && rm -rf /var/lib/apt/lists/*

## build ansible
FROM docker_build AS ansible_build
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ARG PIP_PKGS="wheel\
    ansible==2.8.11\
    molecule \
    docker \
    botocore \
    jinja2\
    PyYAML\
    boto \
    boto3 \
    cryptography"
RUN python3 -m pip  install --no-cache-dir --upgrade  pip \
    && python3 -m pip install --no-cache-dir ${PIP_PKGS}

RUN USERNAME=$(cat /etc/passwd|grep 1000| cut -d ":" -f1); \
    usermod -aG docker ${USERNAME}

# ADD entrypoint /opt/entrypoint
# ENTRYPOINT ["/opt/entrypoint"]



# FROM ansible_build AS systemd_build
# ARG SYSTEMD_PKGS="systemd systemd-sysv"
# RUN apt-get update -y \
#     && apt-get install ${PKG_NAMES} --no-install-recommends -y \
#     && apt-get upgrade -y && apt-get clean -y \&& apt-get install ${PKG_NAMES} --no-install-recommends -y \
#     &&rm -f /lib/systemd/system/multi-user.target.wants/* \
#     /etc/systemd/system/*.wants/* \
#     /lib/systemd/system/local-fs.target.wants/* \
#     /lib/systemd/system/sockets.target.wants/*udev* \
#     /lib/systemd/system/sockets.target.wants/*initctl* \
#     /lib/systemd/system/basic.target.wants/* \
#     /lib/systemd/system/anaconda.target.wants/* \
#     /lib/systemd/system/plymouth* \
#     /lib/systemd/system/systemd-update-utmp* \
#     && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# VOLUME [ "/sys/fs/cgroup" ]
# CMD ["/lib/systemd/systemd"]