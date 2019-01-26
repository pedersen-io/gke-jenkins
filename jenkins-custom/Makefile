export GIT_COMMIT_SHA = $(shell git rev-parse HEAD)

delete:
	kubectl delete deployment jenkins

build:
	docker build ./ -t jenkins-custom

publish:
	docker tag jenkins-custom us.gcr.io/${GCLOUD_PROJECT_ID}/jenkins-custom:latest
	gcloud docker -- push us.gcr.io/${GCLOUD_PROJECT_ID}/jenkins-custom:latest

transform:
	sed -e 's/%GCLOUD_PROJECT_ID%/${GCLOUD_PROJECT_ID}/g' -e 's/%GIT_COMMIT_SHA%/${GIT_COMMIT_SHA}/g' ./deployment-custom.yaml > deployment.sed.yaml

create: transform
	kubectl create -f ./deployment.sed.yaml

deploy: transform
	kubectl apply -f ./deployment.sed.yaml

kubernetes: build publish deploy