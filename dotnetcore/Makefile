export GIT_COMMIT_SHA = $(shell git rev-parse HEAD)

build:
	docker build ./ -t build-dotnetcore

publish-gcloud:
	docker tag build-dotnetcore us.gcr.io/${GCLOUD_PROJECT_ID}/build-dotnetcore:latest
	gcloud docker -- push us.gcr.io/${GCLOUD_PROJECT_ID}/build-dotnetcore:latest

publish-docker:
	docker tag build-dotnetcore derekpedersen/build-dotnetcore:latest
	docker push derekpedersen/build-dotnetcore:latest
