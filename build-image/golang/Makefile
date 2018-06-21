build:
	docker build ./ -t build-golang

publish:
	docker tag build-golang us.gcr.io/derekpedersen-195304/build-golang:latest
	gcloud docker -- push us.gcr.io/derekpedersen-195304/build-golang:latest

kubernetes: build publish
