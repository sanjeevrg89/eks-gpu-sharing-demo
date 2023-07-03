data "aws_ami" "eks_node" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amazon-eks-node-${var.eks_version}*"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

data "aws_ami" "eks_node_gpu" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amazon-eks-gpu-node-${var.eks_version}*"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

data "aws_partition" "current" {}
data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {}