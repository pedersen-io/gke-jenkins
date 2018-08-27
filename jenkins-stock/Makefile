delete:
	kubectl delete deployment jenkins

deploy: delete
	kubectl create f ./deployment-stock.yaml

build:
	docker build ./ -t jenkins-stock

publish: build
	docker tag jenkins-stock us.gcr.io/derekpedersen-195304/jenkins-stock:latest
	gcloud docker -- push us.gcr.io/derekpedersen-195304/jenkins-stock:latest

deploy: publish delete
	kubectl create -f ./jenkins-stock/deployment-stock.yaml

publish-jenkins:
	docker tag build-golang us.gcr.io/derekpedersen-195304/jenkins:latest
	gcloud docker -- push us.gcr.io/derekpedersen-195304/jenkins:latest