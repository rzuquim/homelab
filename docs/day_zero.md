# Day Zero

Since the servers are not provisioned yet we have a chicken and egg problem.

To provision the first server we will move from a "Manual Secret" to an "Automated Secret" to a "Vaulted Secret."

At first the source of truth is my notebook.

To generate the keys and store it safely on the repo:

```bash
ssh-keygen -t ed25519 -f ./ansible_key -C "bootstrap-key"
```

Then move the private key out of the repo, commit and publish the pub key on a public URL.
