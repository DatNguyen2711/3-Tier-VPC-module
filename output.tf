output "my-vpc" {
  value = module.vpc.vpc_id
}




output "public-web-subnet" {
  value = module.vpc.public_web_subnet_ids
}


output "private-app-subnet" {
  value = module.vpc.private_app_subnet_ids

}

output "private-db-subnet" {
  value = module.vpc.private_db_subnet_ids
}


output "internet-gateway" {
  value = module.vpc.internet_gateway_id
}


output "nat-gateway" {
  value = module.vpc.nat_gateway_id
}
