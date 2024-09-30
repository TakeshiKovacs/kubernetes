# first login to azure
` az login`

# Initialise terraform
```
cd terraform

terraform init
```

# Check the plan then apply
```
terraform plan

terraform apply
```

#  Once deployed, install kubectl

`https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-using-native-package-management`

# Download kubectl config
`az aks get-credentials --resource-group rg_aks --name mat-aks`

If you noteice it mentions a windows directory as the location it merged context, install the az client into wsl properly using the below, then restart the terminal

`curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash`
# Test kubectl
`kubectl get nodes`