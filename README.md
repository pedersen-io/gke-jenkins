# GKE Jenkins #

This is my `gke jenkins` setup

## helm charts ##

Add the repo `helm repo add stable https://kubernetes-charts.storage.googleapis.com/`

Install the chart`helm install stable/jenkins --generate-name`

```yaml
NAME: jenkins-1578171870
LAST DEPLOYED: Sat Jan  4 13:04:32 2020
NAMESPACE: default
STATUS: deployed
REVISION: 1
NOTES:
1. Get your 'admin' user password by running:
  printf $(kubectl get secret --namespace default jenkins-1578171870 -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode);echo
2. Get the Jenkins URL to visit by running these commands in the same shell:
  export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/component=jenkins-master" -l "app.kubernetes.io/instance=jenkins-1594685437" -o jsonpath="{.items[0].metadata.name}")
  echo http://127.0.0.1:8080
  kubectl --namespace default port-forward $POD_NAME 8080:8080

3. Login with the password from step 1 and the username: admin


For more information on running Jenkins on Kubernetes, visit:
https://cloud.google.com/solutions/jenkins-on-container-engine
```

### permissions ###

I ran into some issue with the pods not being able to run `helm` commands, so I had to create the following `clusterrolebinding`

```
kubectl create clusterrolebinding permissive-binding --clusterrole=cluster-admin --user=admin --user=kubelet --group=system:serviceaccounts
```
### upgrade jenkins ###

To upgrade the version of `jenkins` run this command `helm upgrade [RELEASE_NAME] jenkins/jenkins [flags]`
