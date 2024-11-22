#### Install ArgoCD
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

#### Patch the service to make it externally available
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

#### Get the IP to login, use this and port 8080 by default to login <<my-ip-address>>:8080 in a web broser and ignore the cert error
kubectl get services --namespace argocd argocd-server --output jsonpath='{.status.loadBalancer.ingress[0].ip}'

#### Get login details, the default user is admin, the PW is randomly generated but we can get it with this
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

#### Regenerate your GH token, visit
https://github.com/settings/tokens/1954663028

#### Log into the argocd ui and add the repo 
https://github.com/TakeshiKovacs/git-ops

#### Check repos and cleanup if necessary
https://github.com/TakeshiKovacs/git-ops/tree/main/kubernetes
This should only have the template folder

https://github.com/TakeshiKovacs/argo-sample-app
Make a small change here to trigger it creating the folder in the git ops repo

#### Port forwarding to see the app
kubectl port-forward svc/my-app 8080:80 -n my-app