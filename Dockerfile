ARG OMDV_VERSION=cooker
ARG ARCH=x86-64

FROM openmandriva/${OMDV_VERSION}:${ARCH}

WORKDIR /RPMS

RUN \
    dnf -y upgrade && \
    dnf -y install abb \
        hostname && \
    dnf clean all && \
    rm -rf /var/cache/dnf && \
    echo -e '#!/bin/bash\n'\
    'dnf -y --refresh builddep "$1"/*.spec && abb build "$1"'\
    > /usr/local/bin/bp && chmod +x /usr/local/bin/bp && \
    mkdir -p /RPMS

