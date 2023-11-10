FROM cruizba/ubuntu-dind:latest

ENV TZ=US
ARG RUNNER_VERSION="2.309.0"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y && apt-get upgrade -y && useradd -m docker
RUN apt-get install -y tzdata

RUN apt-get install -y --no-install-recommends \
    curl jq build-essential libssl-dev libffi-dev python3 python3-venv python3-dev python3-pip git maven vim

RUN mkdir /home/docker/actions-runner && cd /home/docker/actions-runner \
    && curl -O -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

RUN chown -R docker ~docker && /home/docker/actions-runner/bin/installdependencies.sh

COPY entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh

USER docker

ENTRYPOINT ["./entrypoint.sh"]
