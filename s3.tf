resource "aws_s3_bucket" "s3" {
  bucket        = "depi-qal-project-s3"
  force_destroy = true
  tags = {
    Name = "depi-qal-project"
  }
}
