resource "aws_s3_bucket" "packing_list" {
  bucket = "blin-packing-list"
}

resource "aws_s3_object" "packing_list" {
  bucket = aws_s3_bucket.packing_list.id
  key    = "Dockerrun.aws.json"
  source = "Dockerrun.aws.json"
}

resource "aws_elastic_beanstalk_application" "packing_list" {
  name = "packing_list"
}

resource "aws_elastic_beanstalk_application_version" "packing_list" {
  name        = "latest"
  application = aws_elastic_beanstalk_application.packing_list.name
  bucket      = aws_s3_bucket.packing_list.id
  key         = aws_s3_object.packing_list.id
}

resource "random_password" "rails_password" {
  length = 16
}

resource "aws_ssm_parameter" "secret_key_base" {
  name  = "/packing_list/secret_key_base"
  type  = "SecureString"
  value = random_password.rails_password.result
}

resource "aws_elastic_beanstalk_environment" "packing_list" {
  name                = "packing-list"
  application         = aws_elastic_beanstalk_application.packing_list.name
  version_label       = aws_elastic_beanstalk_application_version.packing_list.name
  solution_stack_name = "64bit Amazon Linux 2 v3.5.9 running Docker"

  setting {
    namespace = "aws:ec2:instances"
    name      = "InstanceTypes"
    value     = "t3.micro"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "RAILS_ENV"
    value     = "production"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "SECRET_KEY_BASE"
    value     = aws_ssm_parameter.secret_key_base.value
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DATABASE_PASSWORD"
    value     = aws_ssm_parameter.database_password.value
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DATABASE_USERNAME"
    value     = "postgres"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DATABASE_NAME"
    value     = "packing_list"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DATABASE_HOST"
    value     = aws_db_instance.packing_list.address
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "SingleInstance"
  }

  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "SystemType"
    value     = "basic"
  }

  setting {
    name      = "IamInstanceProfile"
    namespace = "aws:autoscaling:launchconfiguration"
    value     = aws_iam_role.ec2.name
  }

  setting {
    name      = "ServiceRole"
    namespace = "aws:elasticbeanstalk:environment"
    value     = aws_iam_role.eb.arn
  }

  setting {
    name      = "ServiceRoleForManagedUpdates"
    namespace = "aws:elasticbeanstalk:managedactions"
    value     = aws_iam_role.eb.arn
  }

  setting {
    name      = "DisableIMDSv1"
    namespace = "aws:autoscaling:launchconfiguration"
    value     = "true"
  }
}
