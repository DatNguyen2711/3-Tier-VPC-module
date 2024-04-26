module "vpc" {
  source             = "./vpc"
  vpc_cidr_block     = "172.20.0.0/20"
  public_web_subnet  = ["172.20.1.0/24", "172.20.2.0/24", "172.20.3.0/24"]
  private_app_subnet = ["172.20.4.0/24", "172.20.5.0/24", "172.20.6.0/24"]
  private_db_subnet  = ["172.20.7.0/24", "172.20.8.0/24", "172.20.9.0/24"]
  availability_zone  = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
}
