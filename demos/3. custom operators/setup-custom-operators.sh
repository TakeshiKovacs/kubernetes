helm repo add jetstack https://charts.jetstack.io
helm repo update

helm install cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.16 \
  --set installCRDs=true



helm repo add aso2 https://raw.githubusercontent.com/Azure/azure-service-operator/main/v2/charts

helm upgrade --install aso2 aso2/azure-service-operator \
    --create-namespace \
    --namespace=azureserviceoperator-system \
    --set azureSubscriptionID=$AKS_AZURE_SUBSCRIPTION_ID \
    --set azureTenantID=$AKS_AZURE_TENANT_ID \
    --set azureClientID=$AKS_AZURE_CLIENT_ID \
    --set azureClientSecret=$AKS_AZURE_CLIENT_SECRET \
    --set crdPattern='resources.azure.com/*;containerservice.azure.com/*;managedidentity.azure.com/*;storage.azure.com/*'