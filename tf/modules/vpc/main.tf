data "aws_availability_zones" "available" {
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.6.0"

  name                 = var.name
  cidr                 = "10.0.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = []
  public_subnets       = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"]
  enable_dns_hostnames = true

  tags               = var.tags
  public_subnet_tags = var.public_subnet_tags
}
