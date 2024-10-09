# First lets look at our nodes
kubectl get nodes -o wide

# You can see things like the name, if the node is ready to take workloads, networking details and software versions.

# Now, lets look at what Pods are already running
kubectl get pods --all-namespaces=true -o wide

# You will see there are a lot of system Pods running, mostly in the kube-system namespace
# Again various detail is available on each of them

# Now lets look at our namespaces
kubectl get namespaces

# We only have one namespace outside the system ones, default
kubectl get services --all-namespaces=true

# Looks at the details for the DNS service
kubectl describe service kube-dns -n kube-system

# Finally look at the deployment for coredns
kubectl describe deployment coredns -n kube-system