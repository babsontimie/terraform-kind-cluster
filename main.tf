module "kind_cluster" {
  source = "./modules/kind-cluster"
  cluster_name = var.cluster_name
  node_image = var.node_image
}

