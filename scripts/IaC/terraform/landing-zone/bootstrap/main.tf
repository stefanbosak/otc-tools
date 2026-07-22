locals {
  # Defines the roles for the default groups
  # https://docs.otc.t-systems.com/identity-access-management/api-ref/permissions_policies_and_supported_actions/system-defined_permissions.html
  iam_groups = {
    "admin" = {
      group = "otc-administrators"
      roles = [
        "system_all_4",
        "secu_admin",
        "te_admin"
      ]
    },
    "devops" = {
      group = "otc-devops"
      roles = [
        "system_all_3",
        "cce_admin",
        "swr_admin"
      ]
    },
    "developer" = {
      group = "otc-developers"
      roles = [
        "system_all_3",
        "cce_admin",
        "swr_admin"
      ]
    },
    "tester" = {
      group = "otc-testers"
      roles = [
        "system_all_readonly",
        "cce_viewer"
      ]
    },
    "automation" = {
      group = "otc-automation"
      roles = [
        "swr_admin",
        "cce_viewer"
      ]
    }
  }

  # Defines the default tags for the IaC project resources
  default_tags = {
    "terraform_managed" = "true"
    "environment"       = "all"
  }
}

# Main project for the resources:
resource "opentelekomcloud_identity_project_v3" "iac_project" {
  name        = "${var.region}_${var.domain_name}-prj-all-iac"
  description = "Main project for all IaC-managed OTC resources"
  domain_id   = var.domain_id
}

# OBS bucket for remote-backend:
resource "opentelekomcloud_obs_bucket" "tfstate" {
  bucket        = "${var.domain_name}-obs-all-iac"
  acl           = "private"
  region        = var.region
  storage_class = "STANDARD"

  versioning = true

  tags = merge(local.default_tags, var.extra_tags)
}

# Groups referenced by the default IAM role assignments (groups are expected
# to already exist, mirroring the externally-managed groups pattern):
data "opentelekomcloud_identity_group_v3" "default_groups" {
  for_each = { for key, group in local.iam_groups : key => group.group }

  name      = each.value
  domain_id = var.domain_id
}

data "opentelekomcloud_identity_role_v3" "default_roles" {
  for_each = {
    for iam_member in flatten([
      for group_name, group in local.iam_groups : [
        for role in group.roles : {
          key  = "${group_name}-${role}"
          role = role
        }
      ]
    ]) : iam_member.key => iam_member.role
  }

  name = each.value
}

# Domain IAM for default groups:
resource "opentelekomcloud_identity_role_assignment_v3" "default_groups" {
  for_each = {
    for iam_member in flatten([
      for group_name, group in local.iam_groups : [
        for role in group.roles : {
          key        = "${group_name}-${role}"
          group_name = group_name
        }
      ]
    ]) : iam_member.key => iam_member
  }

  group_id  = data.opentelekomcloud_identity_group_v3.default_groups[each.value.group_name].id
  domain_id = var.domain_id
  role_id   = data.opentelekomcloud_identity_role_v3.default_roles[each.key].id
}
