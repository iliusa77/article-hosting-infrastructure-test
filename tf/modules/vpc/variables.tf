variable "name" {
  type        = string
  description = "Name of the VPC"
}

variable "tags" {
  type        = map(string)
  description = "Tags for the VPC"
}

variable "public_subnet_tags" {
  type        = map(string)
  description = "Tags for VPC public subnets"
}
