output "cluster_id" {
    value = module.eks.cluster_id
}

output "cluster_endpoint" {
    value = module.eks.cluster_endpoint
}
output "kms_key_id" {
  value = aws_kms_key.K8s_kms_key.key_id
}

output "ksm_key_arn" {
  value = aws_kms_key.K8s_kms_key.arn
}
output "loadbalancer_dnsname" {
  value = aws_lb.eks_alb.dns_name
}
