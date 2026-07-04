output "backend_vms" {
  value = {
    for k, m in module.vms : k => {
      name      = m.vm_name
      id        = m.vm_id
      nic       = m.nic_id
      public_ip = m.public_ip
    }
  }
}

output "kv_ids" {
  value = { for k, m in module.kvs : k => m.keyvault_ids }
}

output "sql_ids" {
  value = { for k, m in module.sqlservers : k => m.mssql_server_ids }
}
