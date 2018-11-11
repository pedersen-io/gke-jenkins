delete:
	kubectl delete deployment jenkins

build:
	docker build ./ -t jenkins-custom

publish: build
	docker tag jenkins-custom us.gcr.io/${GCLOUD_PROJECT_ID}/jenkins-custom:latest
	gcloud docker -- push us.gcr.io/${GCLOUD_PROJECT_ID}/jenkins-custom:latest

deploy: publish 
	sed -e 's/%GCLOUD_PROJECT_ID%/${GCLOUD_PROJECT_ID}/g' ./deployment-custom.yaml
	kubectl apply -f ./deployment-custom.yaml