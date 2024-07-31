output "iam_user_arn" {
  value = aws_iam_user.terraform_user_name.arn
}

output "ssl_cert_arn" {
  value = aws_acm_certificate.ssl_certificate.arn
}

output "route53_zone_id" {
  value = data.aws_route53_zone.dns_zone.zone_id
}

output "website_url" {
  value = "http://${aws_s3_bucket.website_bucket.bucket}.s3-website-${var.region}.amazonaws.com"
}

output "root_domain" {
  value = var.root_domain
}

output "bucket_regional_domain_name" {
  value = aws_s3_bucket.website_bucket.bucket_regional_domain_name
}

output "s3_bucket_id" {
  value = aws_s3_bucket.website_bucket.id
}

output "coudfront_distribution_id" {
  value = aws_cloudfront_distribution.website_distribution.id
}
