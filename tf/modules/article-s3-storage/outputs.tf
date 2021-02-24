output "key" {
  value     = aws_iam_access_key.article_storage.id
  sensitive = true
}
output "secret" {
  value     = aws_iam_access_key.article_storage.secret
  sensitive = true
}
