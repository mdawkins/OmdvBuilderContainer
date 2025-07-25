ARG OMDV_VERSION=cooker

FROM openmandriva/${OMDV_VERSION}

WORKDIR /RPMS

RUN \
    dnf -y upgrade && \
    dnf -y install abb \
        hostname && \
    dnf clean all && \
    rm -rf /var/cache/dnf && \
    echo -e '\nbp() {\n    dnf -y --refresh builddep "$1"/*.spec && abb build "$1/"\n}\n' >> /root/.bashrc && \
    mkdir -p /RPMS

ENTRYPOINT ["/bin/bash", "-l"]
