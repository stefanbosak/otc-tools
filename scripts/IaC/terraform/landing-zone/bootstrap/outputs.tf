output "iac_bucket_name" {
  value = opentelekomcloud_obs_bucket.tfstate.bucket
}

output "iac_project_id" {
  value = opentelekomcloud_identity_project_v3.iac_project.id
}

output "iac_project_name" {
  value = opentelekomcloud_identity_project_v3.iac_project.name
}

output "domain_id" {
  value = var.domain_id
}

output "domain_name" {
  value = var.domain_name
}

output "region" {
  value = var.region
}

output "iam_groups" {
  value = {
    for key, value in local.iam_groups :
    key => value.group
  }
}
