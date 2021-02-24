variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Deployment region for the environment"
}

variable "env" {
  type        = string
  description = "Environment name"
}

variable "domain_name" {
  type        = string
  description = "Root domain name for the environment"
}

variable "map_users" {
  default = [
    {
      userarn  = "arn:aws:iam::315727832121:user/ilia.eriomenco"
      username = "ilia.eriomenco"
      groups   = ["system:masters"]
    }
  ]
  description = "IAM users that can access the cluster"
}

variable "mongo_username" {
  type        = string
  default     = ""
  description = "Mongo DB password secret"
}

variable "mongo_password" {
  type        = string
  default     = ""
  description = "Mongo DB password secret"
}

variable "docdb_user" {
  type        = string
  description = "Master username for DocumentDB"
}

variable "docdb_pass" {
  type        = string
  description = "Master password for DocumentDB"
}
