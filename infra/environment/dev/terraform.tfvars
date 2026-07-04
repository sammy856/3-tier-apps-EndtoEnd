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
  subnet2 = {
    subnetname       = "backend"
    rgkey            = "rg1"
    vnetkey          = "vnet1"
    address_prefixes = ["10.0.2.0/24"]
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
    subnetkey     = "subnet2"
    vmsize        = "Standard_DS2_v2"
    adminusername = "azureuser"
    adminpassword = "Azure@123"
    identitykey   = "identity1"
    create_public_ip = false
  }
}


sqldetails = {
  sql1 = {
    sqlservername      = "sammysqlserver"
    rgkey              = "rg1"
    administratorlogin = "sammyadmin"
    subnetkey          = "subnet2"
    identitykey        = "identity1"
  }
}

kvdetails = {
  kv1 = {
    keyvaultname = "sammykeyvault"
    rgkey        = "rg1"
    identitykey  = "identity1"
    subnetkey    = "subnet2"
  }
}


kvsecretdetails = {
  kvsecret1 = {
    kvkey      = "kv1"
    secretname = "sqladminpassword"
  }
}


identitydetails = {
  identity1 = {
    identityname = "sammy-uai-1"
    rgkey        = "rg1"
  }
}
