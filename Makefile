export GIT_COMMIT_SHA = $(shell git rev-parse HEAD)

build:
	docker build ./ -t build-jenkins-base

publish:
	docker tag build-golang us.gcr.io/${GCLOUD_PROJECT_ID}/build-jenkins-base:latest
	gcloud docker -- push us.gcr.io/${GCLOUD_PROJECT_ID}/build-jenkins-base:latest