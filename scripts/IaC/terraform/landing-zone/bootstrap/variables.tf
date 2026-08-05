# Mandatory:
variable "domain_id" {
  description = "The OTC domain (tenant) id"
  type        = string
}

variable "domain_name" {
  description = "The OTC domain (tenant) name"
  type        = string
}

variable "region" {
  description = "Region"
  type        = string
}

# Optional:
variable "extra_tags" {
  description = "Extra tags to add to the main project resources"
  type        = map(string)
  default     = {}
}
