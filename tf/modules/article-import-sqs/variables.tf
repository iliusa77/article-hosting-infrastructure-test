variable "import_bucket_name" {
    type        = string
    description = "S3 bucket name for import"
    default     = "test-hive-article-hosting-import"
}

variable "archive_bucket_name" {
    type        = string
    description = "S3 bucket name for archives"
    default     = "test-hive-article-hosting-archive"
}

variable "environment" {
    type        = string
}

variable "sqs_name" {
    type        = string
    description = "Queue name"
    default     = "test-hive-article-hosting-sqs"
}