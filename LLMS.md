# LLMs

Here you can find multiple snippets to reuse when creating a context to get help from LLM models.

## General context

I am setting up a VPS (debian/bookworm64) using ansible playbooks.

My goal is to have a multiple services on it running over docker (rootless).

The ingress of traffic should happen:

- reverse proxy nginx (running on the vps) - ports 80 / 433
- ssh (server management) - port 22
- gitea ssh (running on the host port 2222, but inside a container)
