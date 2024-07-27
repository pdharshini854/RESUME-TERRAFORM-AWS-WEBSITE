terraform {
  backend "s3" {
    bucket         = "priya-resume-challenge-bucket-1"
    key            = "statefile"
    region         = "us-east-1"
    dynamodb_table = "resume_statelock_table"
  }
}
