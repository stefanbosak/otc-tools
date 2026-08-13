# Mandatory:
variable "cluster_name" {
  description = "The name of the CCE cluster"
  type        = string
}

variable "cluster_flavor_id" {
  description = "The CCE cluster flavor id (control-plane sizing), e.g. cce.s2.small"
  type        = string
}

variable "node_flavor" {
  description = "The ECS flavor used for the default node pool, e.g. s2.xlarge.2"
  type        = string
}

variable "availability_zone" {
  description = "The availability zone the default node pool is deployed into"
  type        = string
}

variable "ssh_key_pair" {
  description = "The name of an existing SSH key pair used to access cluster nodes"
  type        = string
}

# Optional:
variable "cluster_type" {
  description = "The CCE cluster type"
  type        = string
  default     = "VirtualMachine"
}

variable "node_os" {
  description = "The node operating system"
  type        = string
  default     = "EulerOS 2.9"
}

variable "vpc_cidr" {
  description = "CIDR range for the dedicated cluster VPC"
  type        = string
  default     = "192.168.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR range for the dedicated cluster subnet"
  type        = string
  default     = "192.168.0.0/24"
}

variable "subnet_gateway_ip" {
  description = "Gateway IP for the dedicated cluster subnet"
  type        = string
  default     = "192.168.0.1"
}

variable "initial_node_count" {
  description = "Initial number of nodes in the default node pool"
  type        = number
  default     = 2
}

variable "min_node_count" {
  description = "Minimum number of nodes when autoscaling the default node pool"
  type        = number
  default     = 2
}

variable "max_node_count" {
  description = "Maximum number of nodes when autoscaling the default node pool"
  type        = number
  default     = 4
}
