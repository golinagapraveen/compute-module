
variable "env_id" {
  description = "Environment id which is the shortname and environment number - eg. noc201 = NOC"
  default     = "noc201"
}

variable "region" {
  description = "Used to change the region for testing"
  default     = "eu-west-1"
}



##subnets to deploy eks cluster in it
variable "subnet1" {}
variable "subnet2" {}
variable "eks_cluster_name" {}
variable "eks_version" {}
