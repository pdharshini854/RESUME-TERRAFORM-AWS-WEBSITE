output "iam_user_arn" {
  value = aws_iam_user.terraform_user_name.arn
}

output "ssl_cert_arn" {
  value = aws_acm_certificate.ssl_certificate.arn
}

output "route53_zone_id" {
  value = data.aws_route53_zone.dns_zone.zone_id
}