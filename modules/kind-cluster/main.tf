terraform {
  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = ">= 0.5.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.19.0"
    }
  }
}

#provider "kind" {}

# Create the Kind cluster

resource "kind_cluster" "this" {
  name            = var.cluster_name
  wait_for_ready  = true
  kubeconfig_path = "${path.module}/kubeconfig"
  node_image      = var.node_image

  kind_config {
    api_version = "kind.x-k8s.io/v1alpha4"
    kind        = "Cluster"

    node {
      role = "control-plane"
    }
    node {
      role = "worker"
    }
    node {
      role = "worker"
    }
  }
}

# Configure Kubernetes provider to use the created Kind kubeconfig
provider "kubernetes" {
  host                   = yamldecode(kind_cluster.this.kubeconfig)["clusters"][0]["cluster"]["server"]
  client_certificate     = base64decode(yamldecode(kind_cluster.this.kubeconfig)["users"][0]["user"]["client-certificate-data"])
  client_key             = base64decode(yamldecode(kind_cluster.this.kubeconfig)["users"][0]["user"]["client-key-data"])
  cluster_ca_certificate = base64decode(yamldecode(kind_cluster.this.kubeconfig)["clusters"][0]["cluster"]["certificate-authority-data"])
}


