terraform {

  required_providers {

    azurerm = {

      source = "hashicorp/azurerm"

      version = "~>4.1"

    }

  }

}

provider "azurerm" {

  features {}

  subscription_id = "8432b329-2a25-4ccb-9771-c72ad6d864df"

}