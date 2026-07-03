rgdetails = {
  rg1 = {
    rgname   = "sammy-rg1"
    location = "Central India"
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
  }
}


vmdetails = {
  vm1 = {
    lvmname       = "frontendvm1"
    rgkey         = "rg1"
    subnetkey     = "subnet1"
    vmsize        = "Standard_DS2_v2"
    adminusername = "azureuser"
    adminpassword = "Azure@123"
  }
  vm2 = {
    lvmname       = "backendvm1"
    rgkey         = "rg1"
    subnetkey     = "subnet1"
    vmsize        = "Standard_DS2_v2"
    adminusername = "azureuser"
    adminpassword = "Azure@123"
  }
}


sqldetails = {
  sql1 = {
    sqlservername      = "sammysqlserver"
    rgkey              = "rg1"
    administratorlogin = "sammyadmin"
  }
}

kvdetails = {
  kv1 = {
    keyvaultname = "sammykeyvault"
    rgkey        = "rg1"
  }
}


kvsecretdetails = {
  kvsecret1 = {
    kvkey      = "kv1"
    secretname = "sqladminpassword"
  }
}
