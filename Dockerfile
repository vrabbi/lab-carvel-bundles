FROM projects.registry.vmware.com/educates/base-environment

COPY --chown=1001:0 . /home/eduk8s/

RUN mv /home/eduk8s/workshop /opt/workshop
RUN curl -L -o /opt/kubernetes/bin/vcluster https://github.com/loft-sh/vcluster/releases/download/v0.3.0-beta.2/vcluster-linux-amd64 && \
    chmod +x /opt/kubernetes/bin/vcluster
RUN fix-permissions /home/eduk8s
