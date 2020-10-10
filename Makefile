export GIT_COMMIT_SHA = $(shell git rev-parse HEAD)

build:
	docker build ./ -t build-jenkins-base

publish-gcloud:
	docker tag build-jenkins-base us.gcr.io/${GCLOUD_PROJECT_ID}/build-jenkins-base:latest
	gcloud docker -- push us.gcr.io/${GCLOUD_PROJECT_ID}/build-jenkins-base:latest

publish-docker:
	docker tag build-jenkins-base derekpedersen/build-jenkins-base:latest
	docker push derekpedersen/build-jenkins-base:latest