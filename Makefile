deploy: delete
	kubectl create -f ./kubernetes/deployment.yaml
	kubectl create -f ./kubernetes/service.yaml
	kubectl create -f ./kubernetes/rbac.yaml

delete:
	kubectl delete deployment nginx-proxy-deployment
	kubectl delete -f ./kubernetes/service.yaml
	kubectl delete -f ./kubernetes/rbac.yaml

kubernetes: deploy

