# TODO

## Features

- [x] DinD image to simulate VPS
- [x] `vagrant` + `virtualbox` to simulate VPS
- [x] `ansible` to setup local test env
- [x] docker rootless + gitea with docker compose
- [ ] configure `docker` in `swarm mode` to declare services
- [ ] `docker stack` to declare `gitea` service in single machine
- [ ] add reverse proxy (`nginx`) to manage subdomain services
- [ ] manage certs `https` and adjust gitea configs
- [ ] hire Localweb VPS's first node and test everything
- [ ] associate Cloudflare dns to VPS
- [ ] gitea custom => robots.txt

## Security

- [ ] ~ufw rules~ iptables
- [ ] ansible with `(ALL) NOPASSWD: ALL` on sudoers does not seem the secure way to implement this
- [ ] gitea using the host's SSH daemon (sshd) passthrough
- [x] on tests, disable shared folders with `VAGRANT_DISABLE_VBOXSYMLINKCREATE=1`
- [x] disable HTTP clone on `gitea`

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

- [ ] why do tests calling `docker` needs `sudo` if the `ansible` user is on the `docker` group?
- [ ] update tests to rootless docker

## Bugs

- [ ] deal with `WARNINGS` on clean `docker.ansible.yml`
