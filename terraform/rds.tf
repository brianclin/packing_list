resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_ssm_parameter" "database_password" {
  name  = "/packing_list/database_password"
  type  = "SecureString"
  value = random_password.db_password.result
}

resource "aws_db_instance" "packing_list" {
  allocated_storage     = 20
  db_name               = "packing_list"
  identifier            = "packing-list"
  engine                = "postgres"
  engine_version        = "15.3"
  instance_class        = "db.t3.micro"
  username              = "postgres"
  password              = aws_ssm_parameter.database_password.value
  storage_encrypted     = true
  multi_az              = false
  max_allocated_storage = 0
  publicly_accessible   = true
}
