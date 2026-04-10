#!/bin/bash

export NCT_VERSION=1.19.0

# assemble sources
rpmdev-setuptree
pushd ~/rpmbuild/SOURCES
go2rpm --profile vendor -v $NCT_VERSION --name nvidia-container-toolkit github.com/NVIDIA/nvidia-container-toolkit
spectool -g /nvidia-container-toolkit.spec
cp -p /nvidia-container-toolkit-selinux.README.txt .
popd

# Show what's new we might need to merge into the spec file from the go SIG
diff -u ~/rpmbuild/SOURCES/nvidia-container-toolkit.spec nvidia-container-toolkit.spec
cp -p nvidia-container-toolkit.spec ~/rpmbuild/SPECS/

# build source rpm
rpmbuild -bs --nodeps ~/rpmbuild/SPECS/nvidia-container-toolkit.spec

# build source rpm with mock preserving root
mock -r fedora-rawhide-x86_64 -N ~/rpmbuild/SRPMS/nvidia-container-toolkit-*.src.rpm

# get a mock shell in the build env
mock -r fedora-rawhide-x86_64 --cwd=/builddir/build/BUILD/nvidia-container-toolkit-${NCT_VERSION}-build/nvidia-container-toolkit-${NCT_VERSION} --shell