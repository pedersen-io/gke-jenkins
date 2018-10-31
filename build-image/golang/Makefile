build:
	docker build ./ -t build-golang

publish:
	docker tag build-golang us.gcr.io/${GCLOUD_PROJECT_ID}/build-golang:latest
	gcloud docker -- push us.gcr.io/${GCLOUD_PROJECT_ID}/build-golang:latest

kubernetes: build publish
