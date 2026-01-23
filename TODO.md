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

- [ ] ansible with `(ALL) NOPASSWD: ALL` on sudoers does not seem the secure way to implement this
- [ ] gitea using the host's SSH daemon (sshd)
- [x] on tests, disable shared folders with `VAGRANT_DISABLE_VBOXSYMLINKCREATE=1`
- [ ] disable HTTP on `gitea`

```
[repository]
DISABLE_HTTP_GIT = true
```

## Docs

- [ ] update README.md to reflect the repo's current state

## Devops

- [ ] run `ansible-lint` on playbooks on before push hooks
- [ ] install a ansible LSP

## Tests

- [ ] why do tests calling `docker` needs `sudo` if the `ansible` user is on the `docker` group
