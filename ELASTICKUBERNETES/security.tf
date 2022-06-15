resource "aws_security_group" "k8s_cluster_node_1" {
    name_prefix = "k8s_cluster_node_1"
    vpc_id = module.vpc.vpc_id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"

        cidr_blocks = [
            "10.0.0.0/8"
        ]
    }

     ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"

        cidr_blocks = [
            "10.0.0.0/8"
        ]
    }
     ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"

        cidr_blocks = [
            "10.0.0.0/8"
        ]
    }
}


resource "aws_security_group" "k8s_cluster_node_2" {
    name_prefix = "k8s_cluster_node_2"
    vpc_id = module.vpc.vpc_id
 
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"

        cidr_blocks = [
            "10.0.0.0/8"
        ]
    }

   ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"

        cidr_blocks = [
            "10.0.0.0/8"
        ]
    }
   ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"

        cidr_blocks = [
            "10.0.0.0/8"
        ]
    }
}


resource "aws_security_group" "all-k8s_cluster" {
    name_prefix = "all_k8s_cluster_nodes"
    vpc_id = module.vpc.vpc_id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"

        cidr_blocks = [
            "10.0.0.0/8"
        ]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"

        cidr_blocks = [
            "10.0.0.0/8"
        ]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"

        cidr_blocks = [
            "10.0.0.0/8"
        ]
    }
}


resource "aws_security_group" "eks_public_elb" {
    name_prefix = "eks_public_elb"
    vpc_id = module.vpc.vpc_id

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"

        cidr_blocks = [
            "0.0.0.0/0"
        ]
    }
   ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"

        cidr_blocks = [
            "0.0.0.0/0"
        ]
    }
}

