variable "docdb_username" {
  type        = string
  description = "Master username for DocumentDB"
}

variable "docdb_password" {
  type        = string
  description = "Master password for DocumentDB"
}

variable "docdb_instance_count" {
  type        = string
  description = "Number of instances that will be created in DocumentDB cluster"
  default     = 1
}

variable "docdb_subnets" {
  description = "List of subnets coming from VPC module"
}

variable "docdb_allowed_ip" {
  description = "List of IP addresses with allowed access to Document DB"
  default     = ["0.0.0.0/0"]
}

variable "vpc_id" {
  type = string
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block to allow access from VPC to Document DB"
}