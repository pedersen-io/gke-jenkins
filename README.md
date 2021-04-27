# GKE Jenkins #

This is my `gke jenkins` setup. Offical `README` can be found here: https://github.com/jenkinsci/helm-charts.

## helm charts ##

Add the repo `helm repo add jenkins https://charts.jenkins.io && helm repo update`

Install the chart`helm install stable/jenkins --generate-name`

```bash
derek@derek-mint:~$ helm install jenkins/jenkins --generate-name
WARNING: "kubernetes-charts.storage.googleapis.com" is deprecated for "stable" and will be deleted Nov. 13, 2020.
WARNING: You should switch to "https://charts.helm.sh/stable" via:
WARNING: helm repo add "stable" "https://charts.helm.sh/stable" --force-update
NAME: jenkins-1619548353
LAST DEPLOYED: Tue Apr 27 11:32:35 2021
NAMESPACE: default
STATUS: deployed
REVISION: 1
NOTES:
1. Get your 'admin' user password by running:
  kubectl exec --namespace default -it svc/jenkins-1619548353 -c jenkins -- /bin/cat /run/secrets/chart-admin-password && echo
2. Get the Jenkins URL to visit by running these commands in the same shell:
  echo http://127.0.0.1:8080
  kubectl --namespace default port-forward svc/jenkins-1619548353 8080:8080

3. Login with the password from step 1 and the username: admin
4. Configure security realm and authorization strategy
5. Use Jenkins Configuration as Code by specifying configScripts in your values.yaml file, see documentation: http:///configuration-as-code and examples: https://github.com/jenkinsci/configuration-as-code-plugin/tree/master/demos

For more information on running Jenkins on Kubernetes, visit:
https://cloud.google.com/solutions/jenkins-on-container-engine

For more information about Jenkins Configuration as Code, visit:
https://jenkins.io/projects/jcasc/


NOTE: Consider using a custom image with pre-installed plugins
```

### permissions ###

I ran into some issue with the pods not being able to run `helm` commands, so I had to create the following `clusterrolebinding`

```
kubectl create clusterrolebinding permissive-binding --clusterrole=cluster-admin --user=admin --user=kubelet --group=system:serviceaccounts
```
