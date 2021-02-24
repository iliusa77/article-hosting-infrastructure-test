resource "aws_acm_certificate" "main_cert" {
  count                     = 1
  domain_name               = var.domain_name
  validation_method         = "DNS"
  subject_alternative_names = var.subject_alternative_names
  tags                      = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

locals {
  zone_name = var.zone_name == "" ? var.domain_name : var.zone_name
}

data "aws_route53_zone" "default" {
  name         = "${local.zone_name}."
  private_zone = false
}

resource "aws_route53_record" "default" {
  zone_id         = join("", data.aws_route53_zone.default.*.zone_id)
  ttl             = var.ttl
  allow_overwrite = true

  for_each = {
    for dvo in aws_acm_certificate.main_cert.0.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
}

resource "aws_acm_certificate_validation" "default" {
  count                   = var.wait_for_certificate_issued ? 1 : 0
  certificate_arn         = join("", aws_acm_certificate.main_cert.*.arn)
  validation_record_fqdns = aws_route53_record.default.*.fqdn
}
