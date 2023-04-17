resource "aws_s3_bucket" "info_bucket" {
  bucket = "terraform-practice-info-bucket"
  tags = {
    "Name"        = "terraform-practice-info-bucket"
    "Description" = "Info Bucket"
  }
    # lifecycle {
  #     prevent_destroy = true
  #    }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.info_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.info_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_acl" "terraform_state" {
  bucket = aws_s3_bucket.info_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "s3_access_block" {
  bucket                  = aws_s3_bucket.info_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "versioning-bucket-config" {
  depends_on = [aws_s3_bucket_versioning.versioning]

  bucket = aws_s3_bucket.info_bucket.id

  rule {
    id = "delete_all"

    noncurrent_version_expiration {
      noncurrent_days = 30
    }

    status = "Enabled"
  }
}