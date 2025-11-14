output "cluster_name" {
  value       = kind_cluster.this.name
  description = "The name of the Kind cluster."
}

output "kubeconfig" {
  value       = kind_cluster.this.kubeconfig
  sensitive   = true
  description = "Raw kubeconfig for the created Kind cluster."
}

