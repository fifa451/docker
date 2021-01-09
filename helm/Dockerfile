FROM beta-base:latest

ARG APP_VERSION
ARG APP_URL
ARG APP_NAME
ARG USERNAME
ARG USERID
ARG GROUPID

ENV HELM_HOME /opt/helm

RUN mkdir -p ${HELM_HOME}/plugins \
    && wget ${APP_URL} -O /opt/${APP_NAME}.tar.gz \
    && tar -xzf  /opt/${APP_NAME}.tar.gz --strip-components 1 -C  /opt/helm/ \
    && chmod +x /opt/helm/${APP_NAME} \
    && chmod +x /opt/helm/tiller \
    && ln -s /opt/helm/${APP_NAME} /usr/bin/${APP_NAME} \
    && ln -s /opt/helm/tiller /usr/bin/tiller    \
    && chown ${USERNAME}:${USERNAME} -R /opt
RUN helm plugin install --home /opt/helm  https://github.com/rimusz/helm-tiller \
    && helm init --home /opt/helm --client-only \
    && helm plugin install --home /opt/helm  https://github.com/databus23/helm-diff --version master \
    && chown ${USERNAME}:${USERNAME} -R /opt

# ## Create app work dir for volumen map
# RUN mkdir -p /app && chown ${USERNAME}:${USERNAME} -R /app /opt
# RUN rm -rf /opt/${APP_NAME}.tar.gz

USER $USERNAME