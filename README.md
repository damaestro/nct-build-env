# Container Environment for Building NCT

Approximates Fedora rawhide build environment.


Setup env and do a build automatically:
```shell
podman compose run --build --rm nct-build-env
```

Manually run the tests (%gotest) from within the running container:
```shell
RPM_ARCH=x86_64 RPM_PACKAGE_RELEASE=1 RPM_PACKAGE_VERSION=1.19.0 RPM_PACKAGE_NAME=nvidia-container-toolkit go test -buildmode pie -compiler gc -ldflags ' -X github.com/NVIDIA/nvidia-container-toolkit/version=1.19.0 -extldflags '\''-Wl,-z,relro -Wl,--as-needed  -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-hardened-ld-errors -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1  -Wl,--build-id=sha1 -specs=/usr/lib/rpm/redhat/redhat-package-notes -Wl,--export-dynamic -Wl,--unresolved-symbols=ignore-in-object-files -Wl,-z,lazy'\''' ./...
```

