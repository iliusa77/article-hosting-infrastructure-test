data "aws_route53_zone" "domain" {
  name = var.domain
}

resource "aws_ses_domain_identity" "ses_domain_identity" {
  domain = var.domain
}

resource "aws_route53_record" "ses_verification_record" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = "_amazonses.${aws_ses_domain_identity.ses_domain_identity.id}"
  type    = "TXT"
  ttl     = "600"
  records = [aws_ses_domain_identity.ses_domain_identity.verification_token]
}

resource "aws_ses_domain_identity_verification" "ses_verification" {
  domain = aws_ses_domain_identity.ses_domain_identity.id

  depends_on = [aws_route53_record.ses_verification_record]
}

resource "aws_ses_email_identity" "notification_email" {
  email = var.ses_domain
}

resource "aws_ses_email_identity" "recipient_email" {
  email = var.receiver_email
}