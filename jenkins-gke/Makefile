delete:
	kubectl delete deployment jenkins

deploy: delete
	kubectl create f ./deployment-gke.yaml

build:
	docker build ./ -t jenkins-gke

publish: build
	docker tag jenkins-gke us.gcr.io/derekpedersen-195304/jenkins-gke:latest
	gcloud docker -- push us.gcr.io/derekpedersen-195304/jenkins-gke:latest

deploy: publish delete
	kubectl create -f ./jenkins-gke/deployment-gke.yaml

publish-jenkins:
	docker tag build-golang us.gcr.io/derekpedersen-195304/jenkins:latest
	gcloud docker -- push us.gcr.io/derekpedersen-195304/jenkins:latest