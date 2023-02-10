terraform {
  backend "s3" {}
}

provider "aws" {
  region = "eu-west-1"

  default_tags {
    tags = {
      TF_Managed = "True"
    }
  }
}

module "compute" {
  source                                       = "./compute"
  eks_cluster_name                             = var.eks_cluster_name
  env_id                                       = var.env_id
  eks_version                                  = var.eks_version
  region                                       = var.region
  subnet1                                      = var.subnet1
  subnet2                                      = var.subnet2
    
}


