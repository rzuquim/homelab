# Local tests

To simulate the production server we are using a _"Docker-in-Docker"_ (`DinD`) setup. It is lightweight way to simulate
the `VPS` environment, although there are some critical nuances.

> [!WARNING]  
> Privileged Mode: To run `DinD`, you usually need to run the outer container with the `--privileged` flag. This gives
> the container nearly full access to your host machine's kernel, which is a security risk in production but fine for
> local testing.

We chose this method instead of a VM because:

- We are testing scripts that interact with the Docker CLI (e.g., a script that builds, runs, or cleans up containers).
- we want a "disposable" environment that starts in seconds.
- We are simulating a server where the primary job is to orchestrate other containers.
- Docker is already a ubiquitous dependency regardless of dev environment.

## Performance issues

- `Storage Drivers`: Running `DinD` can lead to filesystem performance issues (specifically with the
  [overlay2 driver](https://bobcares.com/blog/docker-overlay2/) ).
- `Networking`: Networking can get complex if you're trying to reach a container inside a container from your local
  browser.
