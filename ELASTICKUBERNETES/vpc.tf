data "aws_availability_zones" "available" {}

locals {
    cluster_name = "K8s-Cluster"
}

module vpc {
    source = "terraform-aws-modules/vpc/aws"
    version = "3.2.0"
    name = "${var.vpc_name}"
    cidr = "${var.vpc_cidr}"
    azs = data.aws_availability_zones.available.names
    private_subnets = "${var.private_subnets}"
    public_subnets =  "${var.public_subnets}"
    enable_nat_gateway = "${var.enabled}"
    single_nat_gateway = "${var.enabled}"
    enable_dns_hostnames = "${var.enabled}"

tags = {
    "Name" = "EKS-VPC"
}

public_subnet_tags = {
    "Name" = "EKS-Public-Subnet"
}

private_subnet_tags = {
    "Name" = "EKS-Private-Subnet"
}
}
