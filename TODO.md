# TODO

## Features

- [x] DinD image to simulate VPS
- [x] `vagrant` + `virtualbox` to simulate VPS
- [x] `ansible` to setup local test env
- [x] docker rootless + gitea with docker compose
- [x] add reverse proxy (`nginx`) to manage subdomain services
- [x] add `ansible` public ssh key on server
- `nginx`
  - [ ] manage certs `https` and adjust gitea configs
  - [x] robots.txt
  - [ ] rate limit
  - [ ] global favico
- `gitea`
  - [ ] add public ssh key on default user
  - [ ] and GPG on defaul user
- [ ] hire Localweb VPS's first node and test everything
- [ ] associate Cloudflare DNS to VPS
- `docker`
  - [ ] configure `docker` in `swarm mode` to declare services
  - [ ] `docker stack` to declare `gitea` service in single machine

## Security

- [x] ~ufw rules~ iptables
- [ ] `ansible` with `(ALL) NOPASSWD: ALL` on sudoers does not seem the secure way to implement this
- [ ] gitea using the host's SSH daemon (sshd) passthrough
- [x] on tests, disable shared folders with `VAGRANT_DISABLE_VBOXSYMLINKCREATE=1`
- [x] disable HTTP clone on `gitea`
- [x] adding gitea user's password on ansible vault
- [ ] move pvt keys inside `vault`
- [ ] check: https://github.com/olivomarco/my-ansible-linux-setup
- [ ] check: https://dev-sec.io/
- [x] disable `nginx` welcome page
- [x] custom error pages
- `nginx`
  - [x] forward 403 to 404 page
  - [x] https only
  - [x] external validation (some YT video)
  - [x] block 3000 port (no access but through nginx)
  - [x] cache on cdn
  - [x] review CSP and security headers
  - [x] missing proxy hardening on `./vps/nginx/nginx.gitea.conf`
  - [x] global timeouts
  - [x] limit CDN methods
  - [x] block directory traversal attempts

## Docs

- [ ] update README.md to reflect the repo's current state

## Devops

- [ ] run `ansible-lint` on playbooks on before push hooks
- [ ] install a ansible LSP

## Tests

- [ ] support DNS on tests
- [ ] why do tests calling `docker` needs `sudo` if the `ansible` user is on the `docker` group?
- [ ] update tests to rootless docker
- [ ] test robots.txt

```
curl -I -A "Googlebot/2.1 (+http://www.google.com/bot.html)" http://blog.rzuquim.com
curl -I -A "GPTBot" http://blog.rzuquim.com
```

## Bugs

- [ ] deal with `WARNINGS` on clean `docker.ansible.yml`
- [x] deal with MIME types warns on `nginx`
