terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {  }
  subscription_id = "f407a12a-7102-436f-acad-072d7dbafdd3"
  
}