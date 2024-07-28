#Creating IAM User
resource "aws_iam_user" "terraform_user_name" {
  name = var.iam_user_name
  tags = {
    name = "resume-challenge"
  }
}

#Attaching AdministratorAccess policy 
resource "aws_iam_user_policy_attachment" "terraform_user_policyattachment" {
  user       = aws_iam_user.terraform_user_name.id
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}


#Creating S3 Bucket
resource "aws_s3_bucket" "resume_bucket" {
  bucket = var.bucket_name

  lifecycle {
    prevent_destroy = true
  }
  tags = {
    name = "resume-challenge"
  }

}

#Enable Bucket Versioning
resource "aws_s3_bucket_versioning" "versioning_enabled" {
  bucket = aws_s3_bucket.resume_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

#Creating S3 Bucket Policy
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.resume_bucket.id
  policy = jsonencode(
    {
      Version = "2012-10-17"
      Statement = [
        {
          Effect   = "Allow",
          Action   = "s3:ListBucket",
          Resource = aws_s3_bucket.resume_bucket.arn,
          Principal = {
            AWS = aws_iam_user.terraform_user_name.arn
          }
        },
        {
          Effect   = "Allow",
          Action   = ["s3:GetObject", "s3:PutObject"],
          Resource = "${aws_s3_bucket.resume_bucket.arn}/*",
          Principal = {
            AWS = aws_iam_user.terraform_user_name.arn
          }
        }
      ]

    }
  )
}

#Creating DynamoDB table
resource "aws_dynamodb_table" "resume_statelock_table" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "event"

  attribute {
    name = "event"
    type = "S"
  }

  tags = {
    purpose     = "cloudresumechallenge"
    Environment = "production"
  }
}


resource "aws_dynamodb_table_item" "event_test" {
  table_name = aws_dynamodb_table.resume_statelock_table.name
  hash_key   = aws_dynamodb_table.resume_statelock_table.hash_key

  lifecycle {
    ignore_changes = all
  }

  item = <<ITEM
{
  "event": {"S": "test"},
  "visits":{"N":"0"}
}
ITEM
}

resource "aws_dynamodb_table_item" "event_prod" {
  table_name = aws_dynamodb_table.resume_statelock_table.name
  hash_key   = aws_dynamodb_table.resume_statelock_table.hash_key

  lifecycle {
    ignore_changes = all
  }

  item = <<ITEM
{
  "event": {"S": "prod"},
  "visits":{"N":"0"}
}
ITEM
}
