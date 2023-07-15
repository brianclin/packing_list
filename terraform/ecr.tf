resource "aws_ecr_repository" "packing_list" {
  name                 = "packing_list"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}
