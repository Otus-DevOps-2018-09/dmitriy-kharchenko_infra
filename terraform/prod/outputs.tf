output "app_external_ip_addresses" {
  value = "${module.app.app_external_ip}"
}

output "db_external_ip_addresses" {
  value = "${module.db.db_external_ip}"
}
