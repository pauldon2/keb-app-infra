resource "aws_s3_bucket" "kab_public_bucket" {
  bucket = "kab-app-static"

  tags = {
    Name        = "KAB App public bucket"
  }
}

resource "aws_s3_bucket_ownership_controls" "kab_public_bucket" {
  bucket = aws_s3_bucket.kab_public_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}



resource "aws_s3_bucket_public_access_block" "kab_public_access_block" {
  bucket = aws_s3_bucket.kab_public_bucket.id

  block_public_acls   = false
  block_public_policy = false
  ignore_public_acls  = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "kab_public_bucket" {
  depends_on = [
    aws_s3_bucket_ownership_controls.kab_public_bucket,
    aws_s3_bucket_public_access_block.kab_public_access_block,
  ]

  bucket = aws_s3_bucket.kab_public_bucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "kab_public_bucket_policy" {
  bucket = aws_s3_bucket.kab_public_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = "*"
        Action = [
          "s3:GetObject"
        ]
        Resource = [
          "${aws_s3_bucket.kab_public_bucket.arn}/*"
        ]
      }
    ]
  })

}
