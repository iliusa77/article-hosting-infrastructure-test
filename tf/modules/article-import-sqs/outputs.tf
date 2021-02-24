output "output_sqs_arn" {
    value = aws_sqs_queue.import_queue.arn
}

# output "output_queue_url" {
#     value = data.aws_sqs_queue.data_import_queue.url
# }