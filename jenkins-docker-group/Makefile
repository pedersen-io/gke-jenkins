delete:
	kubectl delete deployment jenkins

deploy: publish delete
	kubectl create -f ./deployment-docker-group.yaml

build:
	docker build ./ -t jenkins-docker-group

publish: build
	docker tag jenkins-docker-group us.gcr.io/derekpedersen-195304/jenkins-docker-group:latest
	gcloud docker -- push us.gcr.io/derekpedersen-195304/jenkins-docker-group:latest

publish-jenkins:
	docker tag build-golang us.gcr.io/derekpedersen-195304/jenkins:latest
	gcloud docker -- push us.gcr.io/derekpedersen-195304/jenkins:latest