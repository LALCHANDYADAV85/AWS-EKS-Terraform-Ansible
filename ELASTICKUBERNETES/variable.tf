variable "region" {
  default = "us-east-1"
}

variable "access_key" {
  default = "AKIAUD64XY"
}

variable "secret_key" {
    default = "a4e+IARpgH9BZsr8aEG8/7sV2"
}
variable "ssh_key" {
    default = "KUBERNETES_TERRAFORM_ANSIBLE_KEY"
}
variable "key_spec" {
  default = "SYMMETRIC_DEFAULT"
}

variable "enabled" {
  default = true
}
variable "encrypted" {
  default = "true"
}
variable "instance_type" {
  default = "t2.small"
}
variable "volume_size" {
  default = "18"
}
variable "desired_capacity" {
  default = "1"
}
variable "volume_type" {
  default = "gp2"
}
variable "cluster_version" {
  default = "1.22"
}
variable "image" {
  default = "ami-02da89ddc4cc9ed18"
}
variable "vpc_name" {
  default = "EKS-VPC"
}
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "private_subnets" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}
variable "public_subnets" {
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}
variable "cluster_name" {
  default = "k8s-EKS-Cluster"
}
