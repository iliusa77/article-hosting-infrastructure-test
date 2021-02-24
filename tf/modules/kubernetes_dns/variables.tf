variable "domain_name" {
  type        = string
  description = "Domain name, e.g. example.com"
}

variable "namespace" {
  type        = string
  description = "Kubernetes namespace, e.g. default"
  default     = "default"
}

variable "owner_id" {
  type        = string
  description = "Name that identifies this instance of ExternalDNS, e.g. my-identifier"
}

variable "role_name" {
  type        = string
  description = "Name of the role, e.g. Accounting-Role"
}

variable "certificate_arn" {
  type        = string
  description = "ARN of SSL certificate"
}
