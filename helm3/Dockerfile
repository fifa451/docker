FROM beta-base:latest

ARG APP_VERSION
ARG APP_URL
ARG APP_NAME
ARG USERNAME
ARG USERID
ARG GROUPID

ENV HELM_HOME /opt/helm3/helm3
ENV XDG_DATA_HOME /opt/helm3/helm3

RUN mkdir -p ${HELM_HOME}/plugins \
    && wget ${APP_URL} -O /opt/${APP_NAME}.tar.gz \
    && tar -xzf  /opt/${APP_NAME}.tar.gz --strip-components 1 -C  /opt/helm3/ \
    && chmod +x /opt/helm3/${APP_NAME} \
    # && chmod +x /opt/helm/tiller \
    && ln -s /opt/helm3/${APP_NAME} /usr/local/bin/${APP_NAME} \
    # && ln -s /opt/helm/tiller /usr/bin/tiller    \
    && chown ${USERNAME}:${USERNAME} -R /opt \
    && helm repo --repository-cache $XDG_DATA_HOME add stable https://charts.helm.sh/stable
RUN  \
    #helm plugin install --home /opt/helm  https://github.com/rimusz/helm-tiller \
    #     && helm init --home /opt/helm --client-only \
    helm plugin install https://github.com/databus23/helm-diff --version master
#&& chown ${USERNAME}:${USERNAME} -R /opt

# ## Create app work dir for volumen map
# RUN mkdir -p /app && chown ${USERNAME}:${USERNAME} -R /app /opt
# RUN rm -rf /opt/${APP_NAME}.tar.gz

USER $USERNAME
