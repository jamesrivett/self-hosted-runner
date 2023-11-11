#!/bin/bash

sudo chmod 666 /var/run/docker.sock

if [ -n "$REPO" ]; then
	REG_TOKEN=$(\
		curl -L -X POST \
		-H "Accept: application/vnd.github+json" \
		-H "Authorization: Bearer ${ACCESS_TOKEN}" \
		-H "X-GitHub-Api-Version: 2022-11-28" \
		https://api.github.com/repos/${USER}/${REPO}/actions/runners/registration-token | jq .token --raw-output)
	
	GIT_URL=https://github.com/${USER}/${REPO}
fi

if [ -n "$ORG" ]; then
	REG_TOKEN=$(\
		curl -L -X POST \
		-H "Accept: application/vnd.github+json" \
		-H "Authorization: Bearer ${ACCESS_TOKEN}" \
		-H "X-GitHub-Api-Version: 2022-11-28" \
		https://api.github.com/orgs/${ORG}/actions/runners/registration-token | jq .token --raw-output)

	GIT_URL=https://github.com/${ORG}
fi

/home/docker/actions-runner/config.sh \
	--url ${GIT_URL} \
	--token ${REG_TOKEN} \
	--name ${RUNNER_NAME} \
	--labels ${LABELS} \
	--runnergroup ${RUNNERGROUP} \
	--work ${WORKDIR} \

/home/docker/actions-runner/run.sh