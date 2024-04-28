module "vpc" {
  source             = "./vpc"
  vpc_cidr_block     = "172.20.0.0/20"
  public_web_subnet  = ["172.20.1.0/24", "172.20.2.0/24", "172.20.3.0/24"]
  private_app_subnet = ["172.20.4.0/24", "172.20.5.0/24", "172.20.6.0/24"]
  private_db_subnet  = ["172.20.7.0/24", "172.20.8.0/24", "172.20.9.0/24"]
  availability_zone  = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
}


# module "app-SG" {
#   source = "./security_groups/"
#   ingress_rules = [
#     {
#       description     = "allow on 443"
#       from_port       = 443
#       to_port         = 443
#       protocol        = "tcp"
#       cidr_blocks     = null
#       security_groups = [module.sg_alb_web.sg_id]
#     },
#     {
#       description     = "allow on 80"
#       from_port       = 80
#       to_port         = 80
#       protocol        = "tcp"
#       cidr_blocks     = null
#       security_groups = [module.sg_alb_web.sg_id]
#     },
#     {
#       description     = "allow on SSH"
#       from_port       = 22
#       to_port         = 22
#       protocol        = "ssh"
#       cidr_blocks     = null
#     },

#   ] #var.ingress_rules_app_server
#   vpc_id         = module.my_vpc.my_vpc_id
#   sg_name        = var.sg_name_app_server
#   sg_description = var.sg_description_app_server
#   egress_rules   = var.egress_rules_app_server
#   #security_groups = var.security_groups_app_server
#   tags_sg = var.tags_sg_app_server
# }

# module "db-SG" {
#   source = "./security_groups/"

#   ingress_rules = [
#     {
#       description = "allow on 3306"
#       from_port   = 3306
#       to_port     = 3306
#       protocol    = "tcp"
#       cidr_blocks = null
#     }

#   ]
#   vpc_id         = module.my_vpc.my_vpc_id
#   sg_name        = "tf_sg_rds"
#   sg_description = "SG for rds"
#   egress_rules = [
#     {
#       description = "allow"
#       from_port   = 3306
#       to_port     = 3306
#       protocol    = "tcp"
#       cidr_blocks = null
#     }
#   ]
#   #security_groups = var.security_groups_app_server
#   tags_sg = {
#     Name = "tf-db-sg",
#     Kind = "practice"
#   }
# }
# module "web-SG" {
#   source = "./security_groups"
#   ingress_rules = [
#     {
#       description     = "allow on 443"
#       from_port       = 443
#       to_port         = 443
#       protocol        = "tcp"
#       cidr_blocks     = null
#     },
#     {
#       description     = "allow on 80"
#       from_port       = 80
#       to_port         = 80
#       protocol        = "tcp"
#       cidr_blocks     = null
#     }
#   ] #var.ingress_rules_web_server
#   vpc_id         = module.my_vpc.my_vpc_id
#   sg_name        = var.sg_name_web_server
#   sg_description = var.sg_description_web_server
#   egress_rules   = var.egress_rules_web_server
#   #security_groups = var.security_groups_web_server
#   tags_sg = var.tags_sg_web_server
# }
