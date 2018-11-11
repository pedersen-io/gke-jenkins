delete:
	kubectl delete deployment jenkins

deploy: delete
	kubectl create f ./deployment-stock.yaml

deploy:
	kubectl apply -f ./deployment-stock.yaml