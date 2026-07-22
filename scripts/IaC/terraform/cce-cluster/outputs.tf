output "cluster_id" {
  value = opentelekomcloud_cce_cluster_v3.this.id
}

output "cluster_name" {
  value = opentelekomcloud_cce_cluster_v3.this.name
}

output "vpc_id" {
  value = opentelekomcloud_vpc_v1.cce.id
}

output "subnet_id" {
  value = opentelekomcloud_vpc_subnet_v1.cce.id
}
