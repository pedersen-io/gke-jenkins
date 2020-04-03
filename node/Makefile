export GIT_COMMIT_SHA = $(shell git rev-parse HEAD)

build:
	docker build ./ -t build-node

publish:
	docker tag build-node us.gcr.io/${GCLOUD_PROJECT_ID}/build-node:latest
	gcloud docker -- push us.gcr.io/${GCLOUD_PROJECT_ID}/build-node:latest