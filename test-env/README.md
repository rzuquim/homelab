# Tests

This folder includes how to test the scripts and Ansible playbooks locally before running them against production
servers.

> [!IMPORTANT]  
> The rationale over the tools choices can be [found here](../docs/local_tests.md).

## Setup

You should install VirtualBox and Vagrant.

> You will probably need to reboot the machine for the Vitual Box Kernel module to load.

To test the environment run:

```shell
vboxmanage --version
vagrant --version`
```

Or, more directly:

```shell
vagrant up
```
