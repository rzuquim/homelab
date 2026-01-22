# TODO

## Features

- [x] DinD image to simulate VPS
- [ ] `vagrant` + `virtualbox` to simulate VPS
- [ ] `ansible` to setup local test env
- [ ] configure `docker` in `swarm mode` to declare services
- [ ] `docker stack` to declare `gitea` service in single machine
- [ ] add reverse proxy (`nginx`) to manage subdomain services
- [ ] hire Localweb VPS's first node and test everything
- [ ] associate Cloudflare dns to VPS

## Security

- [ ] using the host's SSH daemon (sshd)
- [ ] on tests, disable shared folders with `VAGRANT_DISABLE_VBOXSYMLINKCREATE=1`
- [ ] disable HTTP on `gitea`

```
[repository]
DISABLE_HTTP_GIT = true
```
