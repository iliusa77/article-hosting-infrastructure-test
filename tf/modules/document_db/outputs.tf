output "article_docdb_endpoint" {
  value = aws_docdb_cluster.articles_document_db.endpoint
}

output "docdb_sec_group_id" {
  value = aws_security_group.docdb_access.id
}