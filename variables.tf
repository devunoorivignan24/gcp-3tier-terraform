variable "project_id" {
  description = "GCP project ID"
}

variable "region" {
  default     = "us-central1"
  description = "GCP region"
}

variable "zone" {
  default     = "us-central1-a"
  description = "GCP zone"
}

variable "vpc_name" {
  description = "VPC name"
  default     = "devops-vpc"
}

variable "subnet_cidr" {
  description = "Subnet CIDR range"
  default     = "10.0.1.0/24"
}

variable "db_name" {
  default     = "mydatabase"
}

variable "db_user" {
  default = "dbuser"
}

variable "db_password" {
  default = "Password@123"
}
