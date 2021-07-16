#!/usr/bin/env bash

docker run --rm --volume "$(pwd)/charts/aet:/helm-docs" -u $(id -u) jnorwood/helm-docs:latest && cp -r charts/aet/README.md . && rm charts/aet/README.md
