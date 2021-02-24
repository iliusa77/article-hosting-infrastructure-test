variable "bucket_name" {
  type        = string
  description = "Source Bucket name for cantaloupe"
}

variable "cache_key" {
  type        = string
  default     = "cache"
  description = "Bucket Cache key"
}

variable "image_location_prefix" {
  type        = string
  default     = "articles/"
  description = "Prefix for all image storage. Must end with /"
}

variable "s3_endpoint" {
  type        = string
  description = "S3 Endpoint for accessing the bucket"
}

variable "s3_access_key" {
  type        = string
  description = "S3 Access key used to access service"
}

variable "s3_secret_key" {
  type        = string
  description = "S3 Secret key used to access service"
}

variable "service_depends_on" {
  type = any
  default = null
}
