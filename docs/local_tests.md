# Local Testing Strategy

> TL;DR: We are using [vagrant](https://wiki.archlinux.org/title/Vagrant) and
> [vitual box](https://wiki.archlinux.org/title/VirtualBox) to simulate the VPS environment.

## Objectives

- Test scripts/Ansible playbooks
- Ensure 1:1 parity with Debian 12 (Bookworm) production nodes.
- Validate OS-level changes (Firewall, Users, Disk mounts) without risk to the host machine.
- Have a fast and disposable test environment.
- We are only simulating servers where the primary job is to orchestrate containers.

## Docker-in-Docker (DinD) — Discarded

While Docker is ubiquitous and lightweight, it is insufficient for Infrastructure-level testing:

- Kernel Sharing: Even with `--privileged` mode, a container shares the host kernel. Manipulating `ufw` (firewall) or
  `sysctl` settings inside a container can accidentally modify or break the host's networking.
- Process vs. System: Docker is designed to run processes, not operating systems. It lacks a true init system
  (`systemd`) by default, making it difficult to test service persistence and deep user-space sandboxing.

## Other container runtimes: `sysbox` or `podman` - Discarded

These were automatically excluded (without even testing it) to minimize "Environmental Drift".

While they offer better isolation than standard Docker, they introduce non-standard networking stacks and require
host-level configuration changes.

## Vagrant + VirtualBox — Selected

We have opted for full virtualization despite the higher resource overhead since it is the conservative and reliable
choice.

- **Complete Isolation**: Provides a virtualized Kernel and Network Stack. Changes to the firewall or root users are
  strictly confined to the VM.
- **State Management**: Using `vagrant destroy && vagrant up` ensures a "Gold Image" start for every test cycle.
- **Network Parity**: Allows for a static private IP (192.168.x.x), simulating a real-world SSH target for Ansible.
- **Old and reliable**: Boring th

### Cons:

- Requires additional local dependencies: `VirtualBox` and `Vagrant`
- Larger disk footprint (~1GB+ for the box image).
- Slower tests.
