rgdetails = {

  rg1 = {

    rgname = "sammy-rg1"

    location = "East US"

  }

  rg2 = {

    rgname = "sammy-rg2"

    location = "West US"

  }

}


vnetdetails = {

  vnet1 = {

    vnetname = "frontend-vnet"

    rgkey = "rg1"

    address_space = [

      "10.0.0.0/16"

    ]

    dns_servers = [

      "8.8.8.8",

      "8.8.4.4"

    ]

    tags = {

      Environment = "Dev"

      Owner = "Sammy"

    }

  }

}


subnetdetails = {

  subnet1 = {

    subnetname = "frontend"

    rgkey = "rg1"

    vnetkey = "vnet1"

    address_prefixes = ["10.0.1.0/24"]

    service_endpoints = [
      "Microsoft.Sql"
    ]

  }

}


nicdetails = {

  nic1 = {

    nic_name = "linuxvm-nic"

    rgkey = "rg1"

    subnetkey = "subnet1"

    pipkey = "pip1"

    ip_configuration_name = "internal"

    private_ip_allocation = "Dynamic"

    private_ip = null

    tags = {

      Environment = "Dev"

    }

  }

}