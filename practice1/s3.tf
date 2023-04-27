# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration
#---------------------------------------------------------------------------------------------------------------
resource "aws_s3_bucket" "info_bucket" {
  bucket = var.s3_bucket_name
  tags = {
    "Name"        = var.s3_bucket_name
    "Description" = "Info Bucket"
  }
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "info_bucket" {
  bucket = aws_s3_bucket.info_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "info_bucket" {
  bucket = aws_s3_bucket.info_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "info_bucket" {
  bucket = aws_s3_bucket.info_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "info_bucket" {
  depends_on = [aws_s3_bucket_ownership_controls.info_bucket]

  bucket = aws_s3_bucket.info_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_lifecycle_configuration" "info_bucket-config" {
  depends_on = [aws_s3_bucket_versioning.info_bucket]

  bucket = aws_s3_bucket.info_bucket.id

  rule {
    id = "delete_after_30_days"

    expiration {
      days = 30
    }

    noncurrent_version_expiration {
      noncurrent_days           = 40
      newer_noncurrent_versions = 10
    }

    status = "Enabled"
  }
}
