delete:
	kubectl delete deployment jenkins

build:
	docker build ./ -t jenkins-custom

publish: build
	docker tag jenkins-custom us.gcr.io/derekpedersen-195304/jenkins-custom:latest
	gcloud docker -- push us.gcr.io/derekpedersen-195304/jenkins-custom:latest

deploy: publish 
	kubectl apply -f ./deployment-custom.yaml