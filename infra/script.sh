#!/bin/bash

# Variables
RG_NAME="rg-tfstate"
LOCATION="eastus"
STG_NAME="stgdemo2026tf2"       
CONTAINER_NAME="mycontainer"

# 1. Create Resource Group
az group create \
  --name $RG_NAME \
  --location $LOCATION 

# 2. Create Storage Account
az storage account create \
  --name $STG_NAME \
  --resource-group $RG_NAME \
  --location $LOCATION \
  --sku Standard_LRS

# 3. Create Container
az storage container create \
  --name $CONTAINER_NAME \
  --account-name $STG_NAME

echo "✅ Done! RG, Storage Account & Container created."