module "eks"{
    source = "terraform-aws-modules/eks/aws"
    version = "17.1.0"
    cluster_name = "${var.cluster_name}"
    cluster_version = "${var.cluster_version}"
    subnets = module.vpc.private_subnets

    tags = {
        Name = "k8s-EKS-Cluster"
    }

    vpc_id = module.vpc.vpc_id
    workers_group_defaults = {
        root_volume_type = "${var.volume_type}"
    }

    worker_groups = [
        {
            name = "Worker-Node-1"
            instance_type = "${var.instance_type}"
            image_id = "${var.image}"
            asg_desired_capacity = "${var.desired_capacity}"
            key_name = "${var.ssh_key}"
            root_encrypted = "${var.encrypted}"
            root_volume_size = "${var.volume_size}"
            root_kms_key_id = aws_kms_key.K8s_kms_key.key_id
            additional_security_group_ids = [aws_security_group.k8s_cluster_node_1.id]
        },
        {
            name = "Worker-Node-2"
            instance_type = "${var.instance_type}"
            image_id = "${var.image}"
            asg_desired_capacity = "${var.desired_capacity}"
            key_name = "${var.ssh_key}"
            root_encrypted = "${var.encrypted}"
            root_volume_size = "${var.volume_size}"
            root_kms_key_id = aws_kms_key.K8s_kms_key.key_id
            additional_security_group_ids = [aws_security_group.k8s_cluster_node_2.id]
        },
    ]
}

data "aws_eks_cluster" "cluster" {
    name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
    name = module.eks.cluster_id
}
