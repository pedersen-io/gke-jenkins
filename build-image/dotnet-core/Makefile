export GIT_COMMIT_SHA = $(shell git rev-parse HEAD)

build:
	docker build ./ -t build-dotnet-core

publish:
	docker tag build-dotnet-core us.gcr.io/${GCLOUD_PROJECT_ID}/build-dotnet-core:latest
	gcloud docker -- push us.gcr.io/${GCLOUD_PROJECT_ID}/build-dotnet-core:latest

kubernetes: build publish
