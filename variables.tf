variable "region" {
  description = "Region of the AWS resources"
  type        = string
  default     = "us-west-2"
}

variable "cluster_name" {
  description = "Project Name of the AWS Resources"
  type        = string
  default     = "eks-gpusharing"
}

variable "eks_version" {
  description = "EKS version"
  type        = string
  default     = "1.27"
}

variable "tags" {
  description = "Tags for AWS Resource"
  type        = map(string)
  default = {
    Terraform = "true"
  Environment = "test" }

}

variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overriden"
  type        = string
  default     = "10.1.0.0/16"
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = ["10.1.192.0/20", "10.1.208.0/20", "10.1.224.0/20"]
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = ["10.1.0.0/18", "10.1.64.0/18", "10.1.128.0/18"]
}