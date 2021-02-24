provider "aws" {
  region = var.region
}

provider "kubernetes" {
  host                   = module.kube_cluster.kubernetes_config.host
  cluster_ca_certificate = module.kube_cluster.kubernetes_config.cluster_ca_certificate
  token                  = module.kube_cluster.kubernetes_config.token
  load_config_file       = false
  version                = "~> 1.11"
}

provider "helm" {
  kubernetes {
    host                   = module.kube_cluster.kubernetes_config.host
    cluster_ca_certificate = module.kube_cluster.kubernetes_config.cluster_ca_certificate
    token                  = module.kube_cluster.kubernetes_config.token
    load_config_file       = false
  }
  version = "~> 1.2"
}

terraform {
  backend "s3" {
    bucket = "article-hosting-infra-terraform-test"
    # specify with terraform init --backend-config="key=<env>/terraform.tfstate" to make it dynamic
    region = "us-east-1"
  }
  required_version = ">= 0.13.0"
}

locals {
  cluster_name        = "test-hive-eks--${var.env}"
  storage_bucket_name = "test-hive-article-storage--${var.env}"
  s3_endpoint         = "https://s3.${var.region}.amazonaws.com"
}

module "vpc" {
  source = "../../modules/vpc"
  name   = var.env
  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }
}

module "kube_cluster" {
  source       = "../../modules/kubernetes_cluster"
  cluster_name = local.cluster_name
  env          = var.env
  map_users    = var.map_users
  vpc_id       = module.vpc.vpc_id
  subnets      = module.vpc.subnets
}

module "ssl_cert" {
  source                            = "../../modules/acm_certificate"
  domain_name                       = var.domain_name
  zone_name                         = var.domain_name
  subject_alternative_names         = ["*.${var.domain_name}"]
  process_domain_validation_options = true
}

module "kube_dns" {
  source          = "../../modules/kubernetes_dns"
  domain_name     = var.domain_name
  owner_id        = local.cluster_name
  role_name       = module.kube_cluster.worker_iam_role_name
  certificate_arn = module.ssl_cert.arn
}

module "document_db" {
  source = "../../modules/document_db"
  docdb_subnets  = module.vpc.subnets
  vpc_id         = module.vpc.vpc_id
  vpc_cidr       = module.vpc.vpc_cidr
  docdb_username = var.docdb_user
  docdb_password = var.docdb_pass
}

module "kube_ingress_controller" {
  source           = "../../modules/kubernetes_ingress"
  k8s_cluster_name = local.cluster_name
  domain_name      = var.domain_name
}

module "article_storage" {
  source        = "../../modules/article-s3-storage"
  bucket_name   = local.storage_bucket_name
}

module "kube_cantaloupe" {
  source        = "../../modules/kubernetes_cantaloupe"
  bucket_name   = local.storage_bucket_name
  s3_access_key = base64encode(module.article_storage.key)
  s3_secret_key = base64encode(module.article_storage.secret)
  s3_endpoint   = base64encode(local.s3_endpoint)

  service_depends_on = [module.article_storage.key]
}

module "import_sqs" {
  source      = "../../modules/article-import-sqs"
  environment = var.env
}

module "k8s_monitoring" {
  source            = "../../modules/k8s_cloudwatch"
  environment = var.env
  k8s_cluster_name  = local.cluster_name
  k8s_oidc_url      = module.kube_cluster.kubernetes_oidc_url
}

module "import_ses" {
  source  = "../../modules/article-import-ses"
  domain  = var.domain_name
}