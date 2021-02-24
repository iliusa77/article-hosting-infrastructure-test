resource "aws_s3_bucket" "article_storage" {
  bucket = var.bucket_name
  acl    = "private"
}

resource "aws_iam_user" "article_storage" {
  name = "test-hive-article-storage-access-user"
  path = "/system/"
}

resource "aws_iam_access_key" "article_storage" {
  user = aws_iam_user.article_storage.name
}

resource "aws_iam_user_policy" "article_storage_ro" {
  name = "test-hive-article-storage-read"
  user = aws_iam_user.article_storage.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:ListBucket",
        "s3:GetObject",
		"s3:PutObject",
		"s3:GetObjectVersion"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.article_storage.arn}/*",
        "${aws_s3_bucket.article_storage.arn}"
	  ]
    }
  ]
}
EOF
}
