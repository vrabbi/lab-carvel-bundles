#!/bin/bash

curl -L --silent --show-error --fail -o /tmp/carvel.sh https://carvel.dev/install.sh && \
    export K14SIO_INSTALL_BIN_DIR=/opt/kubernetes/bin && \
    sh -x /tmp/carvel.sh && \
    rm /tmp/carvel.sh
