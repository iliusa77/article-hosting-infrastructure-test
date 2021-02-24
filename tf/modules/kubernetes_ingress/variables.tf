variable "k8s_nginx_ingress_version" {
  type        = string
  description = "Image version for Nginx Ingress controller docker image"
  default     = "0.34.0"
}

variable "k8s_cluster_name" {
  type        = string
  description = "K8S cluster name"
}

variable "k8s_ingress_namespace" {
  type        = string
  description = "K8S namespace to place Nginx Ingress controller"
  default     = "default"
}

variable "k8s_ingress_chart_name" {
  type        = string
  description = "Nginx Ingress Helm chart name"
  default     = "ingress-nginx"
}

variable "k8s_ingress_chart_repo" {
  type        = string
  description = "Nginx Ingress Helm chart repository URL"
  default     = "https://kubernetes.github.io/ingress-nginx"
}

variable "k8s_ingress_chart_version" {
  type        = string
  description = "Nginx Ingress Helm chart version"
  default     = "2.11.2"
}

variable "domain_name" {
  type        = string
  description = "Domain name"
}