# We've seen that by defualty communication across namepsaces is allowed
# Let's lock this down

# Lets apply our deny policies
cd demos/1.\ namespaces/

# Lets allow internal comms in both dev and prod namespaces
kubectl apply -f allow-dev-internal-only.yaml

kubectl apply -f allow-prod-internal-only.yaml

# Now we will create a new pod to test connectivity, note that it is in the dev namspace
kubectl run nginx-dev2 --rm -it --image=nginx --namespace=dev -- /bin/sh

# Test connectivity to prod, it should fail
curl http://nginx-prod.prod.svc.cluster.local

# Test connectivity to dev, it should work
curl http://nginx-dev.dev.svc.cluster.local