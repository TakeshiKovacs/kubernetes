# Lets apply our deny policies

cd demos/1.\ namespaces/

kubectl apply -f default-deny-dev.yaml

kubectl apply -f default-deny-prod.yaml

# Lets allow internal comms in both dev and prod namespaces
kubectl apply -f allow-dev-internal.yaml

kubectl apply -f allow-prod-internal.yaml

# Now we will create a new pod to test connectivity
kubectl run nginx-dev2 --rm -it --image=nginx --namespace=dev -- /bin/sh

# Test connectivity to prod, it should fail
curl http://nginx-prod.prod.svc.cluster.local

# Test connectivity to dev, it should work
curl http://nginx-dev.dev.svc.cluster.local