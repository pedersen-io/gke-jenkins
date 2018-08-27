delete:
	kubectl delete deployment jenkins

deploy: delete
	kubectl create f ./deployment-custom.yaml

build:
	docker build ./ -t jenkins-custom

publish: build
	docker tag jenkins-custom us.gcr.io/derekpedersen-195304/jenkins-custom:latest
	gcloud docker -- push us.gcr.io/derekpedersen-195304/jenkins-custom:latest

deploy: publish delete
	kubectl create -f ./jenkins-custom/deployment-custom.yaml

publish-jenkins:
	docker tag build-golang us.gcr.io/derekpedersen-195304/jenkins:latest
	gcloud docker -- push us.gcr.io/derekpedersen-195304/jenkins:latest