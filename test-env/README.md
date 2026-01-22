# Tests

This folder includes how to test the scripts and Ansible playbooks locally before running them against production
servers.

> [!IMPORTANT]  
> The rationale over the tools choices can be [found here](../docs/local_tests.md).

## Setup

You should install VirtualBox, Vagrant and Ansible.

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

## Debug

To debug the VM just hop in it running:

```shell
vagrant ssh
```

### Errors

#### `ModuleNotFoundError: No module named 'ansible'`

Installing Ansible you might encounter an error due to python version mismatch. Happened to me using `pacman`.

```bash
❯ ansible
Traceback (most recent call last):
  File "/usr/bin/ansible", line 5, in <module>
    from ansible.cli.adhoc import main
ModuleNotFoundError: No module named 'ansible'
```

This is possibly a Python version / package rebuild mismatch.

Running `pacman -Ql ansible-core | grep site-packages` I found out that ansible-core expected python `3.14` (not the
version currently installed).

#### Host key verification failed

If this is the first time connecting to the Vagrant box via its IP, the command might fail with a "Host key verification
failed" error.

If that happens and when you are manually testing the connection disable host key checking for this test run by setting
the environment variable `ANSIBLE_HOST_KEY_CHECKING`

```bash
ANSIBLE_HOST_KEY_CHECKING=False ansible all -i 192.168.56.69, -m ping --user ansi
```
