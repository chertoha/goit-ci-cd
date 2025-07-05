provider "aws" {
  region  = "eu-west-1"
  profile = "terraform_user"
}

module "s3_backend" {
  source = "./modules/s3-backend"                # Шлях до модуля
  bucket_name = "terraform-state-bucket-chertok-2"  # Ім'я S3-бакета
  table_name  = "terraform-locks"                # Ім'я DynamoDB
}


module "vpc" {
  source              = "./modules/vpc"           # Шлях до модуля VPC
  vpc_cidr_block      = "10.0.0.0/16"             # CIDR блок для VPC
  public_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]        # Публічні підмережі
  private_subnets     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]         # Приватні підмережі
 availability_zones = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]           # Зони доступності
  vpc_name            = "vpc"              # Ім'я VPC
}