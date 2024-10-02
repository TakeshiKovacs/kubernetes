# Create dev and prod namespaces
kubectl create namespace dev
kubectl create namespace prod

# list our namespaces
kubectl get namespaces

# note there are a bunch of system ones, and the default one, besides the ones we've created

# Deploy an app in the dev namespace
kubectl create deployment nginx-dev --image=nginx --namespace=dev

# Expose the nginx app in dev namespace
kubectl expose deployment nginx-dev --port=80 --type=ClusterIP --namespace=dev

# Deploy an app in the prod namespace
kubectl create deployment nginx-prod --image=nginx --namespace=prod

# Expose the nginx app in prod namespace
kubectl expose deployment nginx-prod --port=80 --type=ClusterIP --namespace=prod

# View all the pods
kubectl get pods --all-namespaces=true

#Get the name of the pod in the dev namepsace
kubectl get pods -n dev

# Start an ssh session in the Dev Pod
kubectl exec --stdin --tty nginx-dev-849767d67-q82k2 -n dev -- /bin/bash

# Test connectivity from Dev to Prod
curl http://nginx-prod.prod.svc.cluster.local

# Type exit to leave the ssh session
