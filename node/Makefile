export GIT_COMMIT_SHA = $(shell git rev-parse HEAD)

build:
	docker build ./ -t build-node

publish-gcloud:
	docker tag build-node us.gcr.io/${GCLOUD_PROJECT_ID}/build-node:latest
	gcloud docker -- push us.gcr.io/${GCLOUD_PROJECT_ID}/build-node:latest

publish-docker:
	docker tag build-node derekpedersen/build-node:latest
	docker push derekpedersen/build-node:latest