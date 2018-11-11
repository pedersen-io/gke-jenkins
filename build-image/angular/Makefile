build:
	docker build ./ -t build-angular

publish:
	docker tag build-angular us.gcr.io/${GCLOUD_PROJECT_ID}/build-angular:latest
	gcloud docker -- push us.gcr.io/${GCLOUD_PROJECT_ID}/build-angular:latest

kubernetes: build publish
