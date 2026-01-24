# 🧪 Tests

This folder includes how to test the scripts and Ansible playbooks locally before running them against production
servers.

> [!IMPORTANT]  
> The rationale over the tools choices can be [found here](../docs/local_tests.md).

## 🖇️ Playbook Dependency Mapping

We use a numeric prefix system to link tests to specific Ansible playbooks.

The first two digits of the file name on the `./tests/` foder determine which playbook must run before the test
executes. On the very beginning of the main `./tests.sh` script there is a map from the number to the script path.

| Prefix | Playbook Mapping          | Purpose                                                  |
| ------ | ------------------------- | -------------------------------------------------------- |
| 00xx   | None                      | Base OS / Infrastructure verification (runs on raw box). |
| 01xx   | ../vps/install/docker.yml | Verifies Docker installation and daemon state.           |
| 02xx   | ../vps/install/gittea.yml | Verifies Gitea installation.                             |

## 🏗️ Setup

To run the environment you must install VirtualBox, Vagrant and Ansible. To run the tests we use Molecule, the Ansible
test runner.

```bash
pacman -Syu virtualbox ansible molecule
```

> You will probably need to reboot the machine for the VirtualBox Kernel module to load.

To test the environment run:

```bash
vboxmanage --version
vagrant --version
```

To execute the tests run:

```bash
tests.sh
```

## 🐞 Manual tests and debug

```bash
vagrant up sandbox
```

- To debug the VM just hop in it running:

```bash
vagrant ssh sandbox
```

- To debug that Ansible can access the Vagrant Box:

```bash
ansible sandbox -m ping
```

- To run a specific playbook:

```bash
ansible-playbook ../vps/install/docker.yml --limit sandbox
```

- To run a some command inside it:

```bash
ansible sandbox -m shell -a "docker --version && docker compose version"
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
