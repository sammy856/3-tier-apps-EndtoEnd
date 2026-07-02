rgdetails = {
  rg1 = {
    rgname   = "sammy-rg1"
    location = "East US"
  }

  rg2 = {
    rgname   = "sammy-rg2"
    location = "West US"
  }
}


vnetdetails = {
  vnet1 = {
    vnetname = "frontend-vnet"
    rgkey    = "rg1"
    address_space = [
      "10.0.0.0/16"
    ]
  }
}


subnetdetails = {
  subnet1 = {
    subnetname       = "frontend"
    rgkey            = "rg1"
    vnetkey          = "vnet1"
    address_prefixes = ["10.0.1.0/24"]
    service_endpoints = [
      "Microsoft.Sql"
    ]
  }
}


vmdetails = {
  vm1 = {
    lvmname       = "frontendvm1"
    rgkey         = "rg1"
    subnetkey     = "subnet1"
    pipkey        = "pip1"
    vmsize        = "Standard_DS2_v2"
    adminusername = "azureuser"
    adminpassword = "Azure@123"
  }
  vm2 = {
    lvmname       = "backendvm1"
    rgkey         = "rg1"
    subnetkey     = "subnet1"
    pipkey        = "pip2"
    vmsize        = "Standard_DS2_v2"
    adminusername = "azureuser"
    adminpassword = "Azure@123"
  }
}


sqldetails = {
  sql1 = {
    sqlservername              = "sammysqlserver"
    rgkey                      = "rg1"
    administratorlogin         = "sammyadmin"
    administratorloginpassword = "Sammy@123"
  }
}


