variable "ses_domain" {
    type        = string
    description = "Email domain for notifications"
    default     = "no-reply@article-hosting.adm-dokuwiki.tk"
}

variable "domain" {
    type        = string
    description = "Domain name"
}

variable "receiver_email" {
    type        = string
    description = "Recipient email"
    default     = "ilia.eriomenco@endava.com"
}