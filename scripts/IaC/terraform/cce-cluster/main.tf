resource "opentelekomcloud_vpc_v1" "cce" {
  name = "${var.cluster_name}-vpc"
  cidr = var.vpc_cidr
}

resource "opentelekomcloud_vpc_subnet_v1" "cce" {
  name       = "${var.cluster_name}-subnet"
  cidr       = var.subnet_cidr
  gateway_ip = var.subnet_gateway_ip
  vpc_id     = opentelekomcloud_vpc_v1.cce.id
}

resource "opentelekomcloud_cce_cluster_v3" "this" {
  name                    = var.cluster_name
  cluster_type            = var.cluster_type
  flavor_id               = var.cluster_flavor_id
  vpc_id                  = opentelekomcloud_vpc_v1.cce.id
  subnet_id               = opentelekomcloud_vpc_subnet_v1.cce.id
  container_network_type  = "overlay_l2"
  authentication_mode     = "rbac"
  kube_proxy_mode         = "ipvs"
}

resource "opentelekomcloud_cce_node_pool_v3" "default" {
  cluster_id        = opentelekomcloud_cce_cluster_v3.this.id
  name              = "${var.cluster_name}-default-pool"
  os                = var.node_os
  flavor            = var.node_flavor
  availability_zone = var.availability_zone
  key_pair          = var.ssh_key_pair
  runtime           = "containerd"

  initial_node_count = var.initial_node_count
  scale_enable       = true
  min_node_count     = var.min_node_count
  max_node_count     = var.max_node_count

  root_volume {
    size       = 40
    volumetype = "SSD"
  }

  data_volumes {
    size       = 100
    volumetype = "SSD"
  }
}
