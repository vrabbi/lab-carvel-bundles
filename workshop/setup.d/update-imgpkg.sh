#!/bin/bash

curl -L --silent --show-error --fail -o /opt/kubernetes/bin/imgpkg https://github.com/vmware-tanzu/carvel-imgpkg/releases/download/v0.11.0/imgpkg-linux-amd64

chmod +x /opt/kubernetes/bin/imgpkg
