build-jenkins:
	docker build ./jenkins -t jenkins

publish-jenkins:
	docker tag build-golang us.gcr.io/derekpedersen-195304/jenkins:latest
	gcloud docker -- push us.gcr.io/derekpedersen-195304/jenkins:latest

build-golang:
	docker build ./build-image/golang -t build-golang

deploy: delete
	kubectl create -f ./deployment.yaml
	#kubectl create -f ./service.yaml
	#kubectl create -f ./rbac.yaml

delete:
	kubectl delete deployment jenkins
	#kubectl delete -f ./service.yaml
	#kubectl delete -f ./rbac.yaml

kubernetes: deploy

