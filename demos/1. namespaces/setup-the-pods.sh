# Refresh credentials if you've rebuilt the cluster
az aks get-credentials --resource-group rg_aks --name mat-aks

# List our namespaces
# note there are a bunch of system ones, and the default one
kubectl get namespaces

# Create dev and prod namespaces
kubectl create namespace dev
kubectl create namespace prod

# List the namespaces again
kubectl get namespaces

# Before we deploy anything, lets view the running Pods
# A Pod is equivelant to a container app
kubectl get pods --all-namespaces=true

# Deploy an app in the dev namespace, typically we would do this with a deployment, or helm chart etc
kubectl create deployment nginx-dev --image=nginx --namespace=dev

# Expose the nginx app in dev namespace, this makes the container available on port 80
kubectl expose deployment nginx-dev --port=80 --type=ClusterIP --namespace=dev

# Deploy an app in the prod namespace
kubectl create deployment nginx-prod --image=nginx --namespace=prod

# Expose the nginx app in prod namespace
kubectl expose deployment nginx-prod --port=80 --type=ClusterIP --namespace=prod

# View all the pods
kubectl get pods --all-namespaces=true

# Lets also see the services we've created
kubectl get service --all-namespaces=true

#Get the name of the pod in the dev namepsace
kubectl get pods -n dev

# Start an ssh session in the Dev Pod
kubectl exec --stdin --tty nginx-dev-849767d67-446wp -n dev -- /bin/bash

# Test connectivity from Dev to Prod, note the name, it is <serviceName>.<namepace>.svc.cluster.local
curl http://nginx-prod.prod.svc.cluster.local

# Type exit to leave the ssh session
