variable "cw_namespace_name" {
    type        = string
    description = "Namespace for monitoring and logging"
    default     = "amazon-cloudwatch"
}

variable "cw_service_acc_name" {
    type        = string
    description = "CW Service Account name"
    default     = "cloudwatch-agent"
}

variable "cw_cluster_role_name" {
    type        = string
    description = "CW Cluster Role name "
    default     = "cloudwatch-agent-role"
}

variable "cw_role_binding_name" {
    type        = string
    description = "CW Agent role binding name"
    default     = "cloudwatch-agent-role-binding"
}

variable "cw_agen_config_name" {
    type        = string
    description = "CW ConfigMap name"
    default     = "cwagentconfig"
}

variable "cw_daemon_set_name" {
    type        = string
    description = "CW Daemon Set name"
    default     = "cloudwatch-agent"
}

variable "fluentd_config_name" {
    type        = string
    description = "FluentD Config Map name"
    default     = "fluentd-config"
}

variable "fluentd_service_acc_name" {
    type        = string
    description = "FluentD Service Account name"
    default     = "fluentd"
}

variable "fluentd_cluster_role_name" {
    type        = string
    description = "FluentD Cluster Role name"
    default     = "fluentd-role"
}

variable "fluentd_role_binding_name" {
    type        = string
    description = "FluentD Cluster role binding name"
    default     = "fluentd-role-binding"
}

variable "fluentd_ds_name" {
    type        = string
    description = "FluentD Daemon set name"
    default     = "fluentd-cloudwatch"
}

variable "k8s_cluster_name" {
    type        = string
    description = "K8S cluster name"
}

variable "k8s_oidc_url" {
    type        = string
    description = "Cluster OIDC URL"
}

variable "environment" {
    type        = string
    description = "Environment name"
}