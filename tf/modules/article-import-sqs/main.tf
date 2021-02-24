resource "aws_s3_bucket" "import_bucket" {
  bucket = "${var.import_bucket_name}--${var.environment}"
  acl    = "private"
}

resource "aws_s3_bucket" "archive_bucket" {
  bucket = "${var.archive_bucket_name}--${var.environment}"
  acl    = "private"
}

resource "aws_sqs_queue" "import_queue" {
  name                      = "${var.sqs_name}--${var.environment}"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
  fifo_queue                = false

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "arn:aws:sqs:*:*:${var.sqs_name}--${var.environment}",
      "Condition": {
        "ArnEquals": { "aws:SourceArn": "${aws_s3_bucket.import_bucket.arn}" }
      }
    }
  ]
}
POLICY

  tags = {
    Environment = var.environment
  }
}

resource "aws_s3_bucket_notification" "bucket_notifications" {
  bucket = aws_s3_bucket.import_bucket.id

  queue {
    id              = "new-zip-article-upload"
    queue_arn       = aws_sqs_queue.import_queue.arn
    events          = ["s3:ObjectCreated:*"]
    filter_suffix   = ".zip"
  }

  queue {
    id              = "new-meca-article-upload"
    queue_arn       = aws_sqs_queue.import_queue.arn
    events          = ["s3:ObjectCreated:*"]
    filter_suffix   = ".meca"
  }

}

# data "aws_sqs_queue" "data_import_queue" {
#   name  = aws_sqs_queue.import_queue.name
# }
