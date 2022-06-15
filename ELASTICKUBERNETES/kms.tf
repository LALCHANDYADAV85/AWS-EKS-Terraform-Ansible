resource "aws_kms_key" "K8s_kms_key" {
  description         = "My KMS Keys For Data Encryption"
  customer_master_key_spec = "${var.key_spec}"
  is_enabled               = "${var.enabled}"
  enable_key_rotation      = "${var.enabled}" 

  tags = {
    Name = "K8s_KMS_KEY"
  }
}
