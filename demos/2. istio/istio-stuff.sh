# Apply a laebl to the default namespace so istio knows to interact with pods we create there
kubectl label namespace default istio-injection=enabled

# Now lets create a v1 of an application, the app doesn't matter so good old nginx
kubectl apply -f my-app-v1.yaml

# Now we will expose this as a service
kubectl apply -f my-app-service.yaml

# Both of the previos commands/resource were default Kubernetes objects
# Now we will deploy an istio gateway
kubectl apply -f my-app-gateway.yaml

# Create a virtual service and destination rule to route incoming traffic
kubectl apply -f my-app-virtual-service.yaml
kubectl apply -f my-app-destination-rule.yaml

# Now lets deploy a new version of our app, we just change the version of nginx in this case
kubectl apply -f my-app-v2.yaml

# Now update our destination rule, my-app-destination-rule.yaml, with the below, this lets it know about version 2
apiVersion: networking.istio.io/v1alpha3
kind: DestinationRule
metadata:
  name: my-app
spec:
  host: my-app
  subsets:
  - name: v1
    labels:
      version: v1
  - name: v2
    labels:
      version: v2

# Then re apply it
kubectl apply -f my-app-destination-rule.yaml

# Now lets update our virtual service, my-app-virtualservice.yaml,  to route 10% of our traffic to our new version
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: my-app
spec:
  hosts:
  - "*"
  gateways:
  - my-app-gateway
  http:
  - route:
    - destination:
        host: my-app
        subset: v1
      weight: 90
    - destination:
        host: my-app
        subset: v2
      weight: 10

kubectl apply -f my-app-virtualservice.yaml

# Now lets look at the traffic splitting
INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
for i in {1..10}; do curl http://$INGRESS_HOST; done