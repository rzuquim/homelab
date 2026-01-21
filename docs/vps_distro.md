# Distro: **Debian**

The consensus among DevOps professionals remains that `Debian` is an exceptional choice for a Docker-heavy production
environment. Our primary use case is simply running a Docker engine and managing the server via `SSH`, `Debian` aligns
perfectly with the **minimalist host** philosophy.

## Reasoning

- **Resource Efficiency**: `Debian` (Stable) is leaner out of the box. In idle tests, a fresh `Debian` 12 install often
  uses `~150–200 MB of RAM`, whereas `Ubuntu Server 24.04 LTS` typically starts around `~350–400 MB` due to background
  services like `Snapd` and more complex cloud-init configurations.
- **Minimalism**: `Debian` doesn't push `Snap` packages.
- **Stability vs. Freshness**: Since we are running Docker, _"freshness"_ is less of an issue. We can run the latest
  `Node.js` inside a container regardless of how _"old"_ the `Debian` host's libraries are. The host only needs to
  provide a stable Kernel and a working `Docker` daemon.

## Downsides

- **Security Defaults**: `Ubuntu` enables [AppArmor](https://documentation.ubuntu.com/server/how-to/security/apparmor/)
  profiles for many services out of the box and has an extremely streamlined "Unattended Upgrades" system that many find
  **easier to configure than Debian's equivalent**.
- **Kernel Features**: If your `Docker` containers need very modern kernel features (like specific `eBPF` improvements
  or the latest `WireGuard` integrations), `Ubuntu`'s kernel is usually 1–2 versions ahead of `Debian Stable`.
