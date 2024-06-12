variable "cidr" {
  default = "10.0.0.0/16"
}

variable "region" {
  default = "us-east-1"
}

variable "availability_zone1" {
  default = "us-east-1a"
}

variable "availability_zone2" {
  default = "us-east-1b"
}

variable "subnet1_cidr" {
  default = "10.0.0.0/24"
}

variable "subnet2_cidr" {
  default = "10.0.1.0/24"
}

variable "domain_name" {
  default = "explorewithram.com"
}

variable "subdomain" {
  default = "info"
}

variable "s3_bucket_name" {
  default = "ramnarendransterraform2024project"
}

variable "ami_id" {
  default = "ami-0c7217cdde317cfec"
}

variable "instance_type" {
  default = "t2.micro"
}