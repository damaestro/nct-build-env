#
# Containerfile for Fedora-based build environment
# to replicate Fedora's build system & packager worklflow.
#

# Development image
FROM fedora:rawhide

# Packager tools
RUN dnf install -yq \
    fedora-packager \
    go2rpm \
    && dnf clean all

# Instructions
COPY build.sh /build.sh
COPY nvidia-container-toolkit.spec /nvidia-container-toolkit.spec
COPY nvidia-container-toolkit-selinux.README.txt /nvidia-container-toolkit-selinux.README.txt


# Set entrypoint
ENTRYPOINT ["/build.sh"]