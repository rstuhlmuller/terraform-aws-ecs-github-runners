# base image
FROM --platform=linux/amd64 ubuntu:22.04

HEALTHCHECK CMD curl --fail http://localhost:8080 || exit 1

#input GitHub runner version argument
# ARG RUNNER_VERSION
ARG PACKAGE_LIST
ENV DEBIAN_FRONTEND=noninteractive

LABEL BaseImage="ubuntu:22.04"
LABEL RunnerVersion=${RUNNER_VERSION}

# update the base packages + add a non-sudo user 
RUN apt-get update -y && apt-get upgrade -y && useradd -m docker

# install the packages and dependencies along with jq so we can parse JSON (add additional packages as necessary)
RUN apt-get install -y --no-install-recommends \
    curl \
    nodejs \
    wget \
    unzip \
    vim \
    git \
    jq \
    build-essential \
    libssl-dev \
    libffi-dev \
    python3 \
    python3-venv \
    python3-dev \
    python3-pip \
    sudo \
    docker \
    bash 

# cd into the user directory, download and unzip the github actions runner
RUN cd /home/docker && mkdir actions-runner && cd actions-runner \
    && curl -O -L https://github.com/actions/runner/releases/download/v2.311.0/actions-runner-linux-x64-2.311.0.tar.gz \
    && tar xzf ./actions-runner-linux-x64-2.311.0.tar.gz

# install some additional dependencies
RUN chown -R docker ~docker && /home/docker/actions-runner/bin/installdependencies.sh

# add over the start.sh script
COPY scripts/start.sh start.sh

# make the script executable
RUN chmod +x start.sh

# set the user to "docker" so all subsequent commands are run as the docker user
USER docker

# set the entrypoint to the start.sh script
ENTRYPOINT ["./start.sh"]
