FROM alpine:latest

ENV PKG_LIST="curl unzip ca-certificates"
ENV KUBECTL_VER="v1.16.0"
ENV CONSUL_VER="1.6.1"
ENV KUBECTL_URL="https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VER}/bin/linux/amd64/kubectl"
ENV CONSUL_URL="https://releases.hashicorp.com/consul/${CONSUL_VER}/consul_${CONSUL_VER}_linux_amd64.zip"
RUN apk add ${PKG_LIST} --no-cache
WORKDIR /usr/local/bin

# install kubectl
RUN \
    wget ${KUBECTL_URL} -O /usr/local/bin/kubectl \
    &&  chmod 755 /usr/local/bin/kubectl

RUN \
    wget $CONSUL_URL -O /tmp/consul.zip \
    && cd /usr/local/bin \
    && unzip /tmp/consul.zip \
    && chmod 755 /usr/local/bin/consul

# cleanup
# RUN apk delete ${PKG_LIST}