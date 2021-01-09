FROM beta-base
ARG USERNAME
ENV PATH="/opt/awscli/bin:$PATH"
ENV HELM_HOME /opt/helm
## Update the certs
COPY --from=kops:latest /opt/kops /usr/local/bin/kops
COPY --from=kubectl:latest /opt/kubectl /usr/local/bin/kubectl
COPY --from=terraform:latest /opt/terraform /usr/local/bin/terraform
COPY --from=sops:latest /opt/sops /usr/local/bin/sops
COPY --from=consul:latest /opt/consul /usr/local/bin/consul
COPY --from=helm:latest /opt/helm/helm /usr/local/bin/helm
COPY --from=helm:latest /opt/helm/ /opt/helm
COPY --from=awscli:latest /opt/awscli /opt/awscli
RUN chown $USERNAME:$USERNAME -R /opt
# ENTRYPOINT ["tail", "-f", "/dev/null"]
