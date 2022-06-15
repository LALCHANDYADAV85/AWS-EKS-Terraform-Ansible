**ReadMe**

This repo contains a set of Terraform modules that can be used to
provision an Elastic Kubernetes (EKS) cluster on AWS.

First, we have to [create your AWS
account](https://signin.aws.amazon.com/signin?redirect_uri=https%3A%2F%2Fconsole.aws.amazon.com%2Fconsole%2Fhome%3Fstate%3DhashArgs%2523%26isauthcode%3Dtrue&client_id=arn%3Aaws%3Aiam%3A%3A015428540659%3Auser%2Fhomepage&forceMobileApp=0&code_challenge=gjVJoawn3_fcc7rrNxkhtTCQoJJdCpOB9cNxhXTxpM4&code_challenge_method=SHA-256).
We will have to enter the credit card but every component you will
deploy will not incur fees.

Then we also have to **install** [**AWS
CLI**](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html).

After these steps, you can **log in to your account**.

## **Step 1: Set up Terraform with AWS**

The first thing to **set up** is **our Terraform**. We will **create
an** **AWS IAM users for Terraform**.

In our **AWS console**, we have gone to the **IAM section** and
**created a user named "FullAccess"**. Then have **added our user to a
group** named "FullAccessGroup". Attaches to this group the following
rights:

-   **AdministratorAccess**

-   **AmazonEKSClusterPolicy**

After these steps, AWS will provide us with a **Secret Access Key and
Access Key ID**. We had **Saved them preciously** because this was the
only time AWS gives it to you.

In our own console, we have created a \~/.aws/credentials file and put
your credentials in it:

\[default\]\
aws_access_key_id=\*\*\*\*\*\*\*\*\*\*\*\
aws_secret_access_key=\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*

The last step is to **create this file**:

\[default\]\
region=eu-west-3

**Step 2: Creation of EC2 instance**

First, we launched an EC2 instance with Amazon Linux AMI inside which we
were able to run some Terraform.

This was done first connecting to the ec2 instance using putty.

1\. First of all, we need to have puttygen and Putty exe for connecting
to the server from Windows (or the SSH command on Linux).

-   We had downloaded putty by following link.
    <https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html>

-   Then we went to putty.exe and clicked on ***64*** ***bit.***

-   Then we went to puttygen.exe then click on ***64*** ***bit*** to
    download the tool.

-   Then we went to physical location and check the putty and puttygen
    tools.

-   After that, we converted pem file to ppk file by using puttygen by
    opening puttygen by typing puttygen on search bar.

-   Then we opened puttygen and clicked on ***Load.***

-   Then we selected the pem file from physical location and clicked on
    ***open and then we clicked on OK.***

-   Then we saved ppk file with name of linux.

-   By following above steps, we can connect to the server with help of
    ppk file by using putty.

-   Then we went to the instance and copied Public IPV4 address.

-   Then we opened the putty by typing putty on search bar

-   Then we specified Public IPV4 of our instance which we copied

-   Then to setup connection at the left side menu then select "SSH" and
    then select "Auth". We had clicked on the ***browse.***

-   Then we selected ppk file from physical location and clicked on
    ***open.***

2\. For downloading and installing Terraform we had followed the
following steps:

-   First, we need to Terraform official website by using the link
    below.

[https://www.terraform.io/downloads.html](https://aws.amazon.com/console/)

-   Select Linux 64-bit and copy the link address.

-   Then we went inside the Linux Server Terminal.

-   Then we downloaded the package using the copied url with wget
    command.

-   After that we saw the terraform zip file which was downloaded.

-   Then unzipped the package using **Unzip Terraform package.**

-   After that we saw the terraform binary file.

-   Then we executed the binary file for installing terraform.

./terraform

-   Then we verified the version using the following command:

terraform \--version

-   After that we set the path by using the following command:

Pwd

echo \$\"export PATH=\\\$PATH:\$(pwd)\" \>\> \~/.bash_profile

source \~/.bash_profile

Then we started the terraform.

## **Step 3. Creation of directories and Terraform files**

Inside the EC2 instance we have created a directory named
"AWSEKSCLUSETR". In that directory, we have created various terraform
files to create the infrastructure and to deploy the EKS cluster.

The contents of the "AWSEKSCLUSETR" directory are as follows:

1\) alb.tf

2\) eks.tf

3\) kms.tf

5\) kubernetes.tf

6\) outputs.tf

7\) provider.tf

8\) security.tf

11\) variable.tf

12\) vpc.tf

.

-   Among These files first we had created the vpc.tf file.Inside the
    vpc.tf file we had defined Public and Private subnet and other
    details so as to create a vpc network named "EKS-VPC" which will be
    used in the creation of our EKS cluster.

-   Then we created a kms.tf file which is going to be used in the
    encryption of data.

-   Then we created the provider.tf file. This file contains all the
    information about which **provider you want to use with Terraform**.
    We specify here to Terraform that we want to use an **AWS
    provider.** As here we are also providing the details of region,
    access and secret key.

NOTE: Public and Private subnets that we had created in the vpc.tf are
EKS-Public-Subnet (\"10.0.3.0/24 \", \"10.0.4.0/24 \") and
EKS-Private-Subnet (\"10.0.2.0/24 \", \"10.0.1.0/24 \") and route tables
are also created named EKS-VPC with route IDs ("rtb-0476945cbd0ce416b","
rtb-07fc5cd2b70595e80\")

-   Then we created output.tf in this file we have mentioned the name of
    what values we want to see when we would perform "terraform apply"
    such as cluster_id, \"cluster_endpoint\", \"kms_key_id\",
    \"ksm_key_arn\" and \"loadbalancer_dnsname\".

-   Then we created variables.tf file in that file input variables let
    us customize aspects of Terraform modules without altering the
    module\'s own source code.

-   Then we created the security.tf file in which we specified the
    security groups that would be needed in the creation of the cluster
    and in the handling of traffic from the internet, these security
    groups are specified for 1) all cluster nodes 2) for node 1 3)for
    node 2 and 4) for eks public load-balancer.

The Security groups that we created are as follows:

Security group for Kubernetes ELB

EKS cluster security group.

KUBERNETES_TERRAFORM_ANSIBLE_CODE_SG

NOTE: All other security groups are managed by terraform.

-   Then we created a kubernetes.tf file. This file contains
    "kubernetes" as a provider because of this file all the dependencies
    and required permissions will be given at the time of cluster
    creation.

-   After that, we created alb.tf file in which there are target groups
    for EKS nodes and listeners for our cluster to connect to the
    frontend.

-   Then we have the eks.tf file in which we have specified the source
    module, name tag to give name to the cluster,node groups to specify
    the worker nodes, vpc id which will direct to the vpc id module to
    launch the cluster.

After running the terraform commands then we will have the cluster of
the following configuration and all the files that are mentioned above
we will provide the source code of it \[**upon request\]**

## 

## **Configuration**

You can configure your config with the following input variables:

  **Name**              **Description**                      **Default**
  --------------------- ------------------------------------ ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  cluster-name          The name of your EKS Cluster         [k8s-EKS-Cluster](https://us-east-1.console.aws.amazon.com/eks/home?region=us-east-1#/clusters/k8s-EKS-Cluster)
  aws-region            The AWS Region to deploy EKS         us-east-1
  availability-zones    AWS Availability Zones               \[\"us-east-1a\", \"us-east-1b\", \"us-east-1c\"\]
  k8s-version           The desired K8s version to launch    1.22
  node-instance-type    Worker Node EC2 instance type        t2.small
  vpc-subnet-cidr       Subnet CIDR                          10.0.0.0/16
  private-subnet-cidr   Private Subnet CIDR                  \[\"10.0.2.0/24 \", \"10.0.1.0/24 \"\]
  Public-subnet-cidr    Public Subnet CIDR                   \[\"10.0.3.0/24 \", \"10.0.4.0/24 \"\]
  ec2-key-public-key    EC2 Key Pair for bastion and nodes   ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 <email@example.com>

### 

### **IAM**

The AWS credentials must be associated with a user having at least the
following AWS managed IAM policies

-   IAMFullAccess

-   AutoScalingFullAccess

-   AmazonEKSClusterPolicy

-   AmazonEKSWorkerNodePolicy

-   AmazonVPCFullAccess

-   AmazonEKSServicePolicy

-   AmazonEKS_CNI_Policy

-   AmazonEC2FullAccess

Most of the IAM policies that are mentioned above will be automatically
created with the kubernetes.tf file.

### **Terraform**

You need to run the following commands to create the resources with
Terraform:

terraform init

terraform plan

terraform apply

TIP: you should save the plan state terraform plan -out eks-state or
even better yet, setup [remote
storage](https://www.terraform.io/docs/state/remote.html) for Terraform
state. You can store state in an [S3
backend](https://www.terraform.io/docs/backends/types/s3.html), with
locking via DynamoDB

### 

### 

### 

**Integration of Ansible**

In our EC2 instance inside our "KUBERNETES_TERRAFORM_ANSIBLE" directory
we have created the following files so as to connect our main server to
the worker nodes of our EKS cluster.

1)  ansible.cfg

2)  ansible.log

3)  AWSEKSCLUSETR

4)  deploy.yaml /**\[Playbook.yml created as deploy.yml\]**

5)  hosts

6)  pod.yaml

7)  svc.yaml

-   We have created a file named "hosts" in the location
    "/home/ec2-user/KUBERNETES_TERRAFORM_ANSIBLE/hosts" where the Ip
    address of our EKS Cluster is stored.

-   We have created ansible.cfg file.In the ansible.cg file we have
    specified the privileges such as

become = True

become_method = sudo

become_user = root

become_ask_pass = False

And we have also specified path to inventory file where our host IP of
our cluster is mentioned other than that we have specified the
following:

sudo_user = root

ask_pass = False

remote_user = ubuntu

log_path = /home/ec2-user/KUBERNETES_TERRAFORM_ANSIBLE/ansible.log

private_key_file = /home/ec2-user/eks-cluster.pem

deprecation_warnings = False

host_key_checking = False

\#interpreter_python = /usr/bin/python3

\#ansible_python_interpreter = /usr/bin/python3

ansible_python_interpreter = \"/usr/bin/env python\"

ansible_connection = local

gather_facts = True

-   Then we created ansible.log where all the logs of the all the
    activities regarding pod.yaml,srv.yaml and our playbook.yaml
    (deploy.yaml) are stored.

-   After that we created pod.yaml to specify the pod configuration and
    we also created svc.yaml to specify the services inside our worker
    nodes.

-   Then we have created deploy.yaml file which is our playbook where
    all the automated ansible code is written in which we have specified
    the name, hosts and also specified the tasks to be performed on the
    worker nodes.

**NOTE:**

### **Setup kubectl**

Setup your KUBECONFIG

terraform output kubeconfig \> \~/.kube/eks-cluster\
export KUBECONFIG=\~/.kube/eks-clust
