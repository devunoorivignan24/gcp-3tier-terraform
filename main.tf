module "network" {
  source      = "./modules/network"
  vpc_name    = var.vpc_name
  region      = var.region
  subnet_cidr = var.subnet_cidr
}

module "compute" {
  source  = "./modules/compute"
  region  = var.region
  subnet  = module.network.subnet_name
}

module "cloudsql" {
  source      = "./modules/cloudsql"
  region      = var.region
  db_name     = var.db_name
  db_user     = var.db_user
  db_password = var.db_password
}

module "loadbalancer" {
  source         = "./modules/loadbalancer"
  instance_group = module.compute.instance_group
}
