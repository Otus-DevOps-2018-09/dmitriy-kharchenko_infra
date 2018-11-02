output "app_external_ip_address" {
  value = "${module.app.app_external_ip}"
}

output "db_external_ip_address" {
  value = "${module.db.db_external_ip}"
}

output "db_internal_ip_address" {
  value = "${module.db.db_internal_ip}"
}
