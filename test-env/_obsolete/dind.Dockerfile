####################
# Docker in docker container to simulate VPS
####################
# WARN: we assume you are running this from the repo's home
# WARN: if we change the version we MUST change the `Suites: bookworm` on the `docker.sources`

FROM debian:12-slim

####################
# TOOLS
####################

RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    sudo && \
    # NOTE: removing apt catalog to keep the image layer lean
    rm -rf /var/lib/apt/lists/*

####################
# DOCKER 
# Install instructions from: https://docs.docker.com/engine/install/debian/
####################

# Add Docker's official GPG key
RUN install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
COPY ./test-env/config/docker.sources /etc/apt/sources.list.d/docker.sources 

# Install Docker Engine
RUN apt-get update && apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin && \
    # NOTE: removing apt catalog to keep the image layer lean
    rm -rf /var/lib/apt/lists/*

####################
# ENTRYPOINT
####################
COPY ./test-env/config/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["bash"]
