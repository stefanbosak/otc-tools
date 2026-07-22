output "organization_id" {
  value = opentelekomcloud_swr_organization_v2.this.id
}

output "organization_name" {
  value = opentelekomcloud_swr_organization_v2.this.name
}

output "swr_login_server" {
  value = "swr.${var.region}.otc.t-systems.com"
}
