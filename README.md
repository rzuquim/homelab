[<img align="right" src="./_assets/png/logo-black.png" width="100" alt="Rafael Zuquim" />](https://rzuquim.com)

# rzuquim’s homelab scripts

Scripts to learn `dev-ops` and setup my homelab.

## Local tests

To simulate the production server we are using a _"Docker-in-Docker"_ (`DinD`) setup. Please,
[read the docs](`docs/local_tests.md`) before proceeding.

```bash
cd ./test-env/
# if not already built
docker build --file test-env/dind.Dockerfile --tag dind:debian .
docker run --privileged --rm -it dind:debian
```
