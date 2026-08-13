# Mandatory:
variable "organization_name" {
  description = "The SWR organization (namespace) name; repositories are created implicitly on first docker push"
  type        = string
}

variable "region" {
  description = "Region"
  type        = string
}
