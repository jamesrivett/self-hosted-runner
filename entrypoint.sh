#!/bin/bash

/home/docker/actions-runner/config.sh \
	--url ${GIT_URL} \
	--token ${REG_TOKEN} \
	--name ${RUNNER_NAME} \
	--labels ${LABELS} \
	--runnergroup ${RUNNERGROUP} \
	--work ${WORKDIR} \

/home/docker/actions-runner/run.sh