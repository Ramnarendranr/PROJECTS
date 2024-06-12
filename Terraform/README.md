# Project Title: Setting Up a Secure VPC with EC2 Instances and an Application Load Balancer Using Terraform

## Introduction

### What is Terraform?
```
Terraform is an open-source Infrastructure as Code (IaC) tool created by HashiCorp. It allows users to define and provision infrastructure using a high-level configuration language. Terraform automates the creation and management of infrastructure resources such as virtual machines, storage, and networking components. By using Terraform, you can manage and scale your cloud infrastructure consistently and efficiently.
```

## Project Overview
### Objective
```
In this project, we use Terraform to create and manage an AWS infrastructure that includes a Virtual Private Cloud (VPC), subnets, security groups, an Internet Gateway, EC2 instances, an Application Load Balancer (ALB), and associated components. The infrastructure is designed to host a web application accessible via HTTP and HTTPS.
```

## Methodology
### Steps to Setup the Project

1. Install Terraform: Ensure Terraform is installed on your local machine. You can download it from the official Terraform website.
2. Setup AWS CLI: Configure AWS CLI with your credentials by running aws configure.
3. Define Terraform Configuration Files: Create the following Terraform configuration files in your project directory:

                    * main.tf
                    * provider.tf
                    * variable.tf
                    * userdata1.sh
                    * userdata2.sh
                    
4. Initialize Terraform: Run **terraform init** to initialize the Terraform configuration. This will download the necessary providers and set up your Terraform environment.
5. Plan the Infrastructure: Run **terraform plan** to see the planned actions that Terraform will take to create your infrastructure. This helps you review and verify the changes before applying them.
6. Apply the Configuration: Run **terraform apply** to create the infrastructure. Review the proposed changes and type yes to confirm. Terraform will provision the resources as defined in your configuration files.

## Implementation

### VPC and Subnets:
```
We define a VPC with a specified CIDR block (var.cidr) and create two subnets (aws_subnet.sub1 and aws_subnet.sub2) within different availability zones (var.availability_zone1 and var.availability_zone2). Each subnet is configured to enable automatic assignment of public IP addresses (map_public_ip_on_launch = true).
```

### Security Group:
```
A security group (aws_security_group.sg) is defined to control inbound and outbound traffic to our EC2 instances. It allows HTTP (port 80) and SSH (port 22) traffic from any IP (0.0.0.0/0).
```

### S3 Bucket:
```
An AWS S3 bucket (aws_s3_bucket.example) is provisioned to store application data and assets.
```

### EC2 Instances:
```
Two EC2 instances (aws_instance.webserver1 and aws_instance.webserver2) are launched. Each instance uses the specified AMI (var.ami_id) and instance type (var.instance_type). Importantly, each instance is configured with unique user data scripts (userdata1.sh and userdata2.sh) to customize their configuration upon boot.
```

### Application Load Balancer (ALB):
```
An ALB (aws_lb.mylb) is created to distribute incoming HTTP traffic across the EC2 instances. It is associated with both subnets (aws_subnet.sub1 and aws_subnet.sub2) and configured to forward traffic to a target group (aws_lb_target_group.mytg) listening on port 80.
```

### Route 53 DNS Management:
```
We manage DNS records using Route 53 (aws_route53_zone.main and aws_route53_record.info). An Alias record (aws_route53_record.info) is created to route traffic from ${var.subdomain}.${var.domain_name} to the ALB's DNS name (aws_lb.mylb.dns_name).
```

### User Data Scripts
```
userdata1.sh: This script is executed during the launch of aws_instance.webserver1. It configures the instance-specific settings and installs necessary software packages for the application.

userdata2.sh: This script is executed during the launch of aws_instance.webserver2. It includes configurations specific to this instance, ensuring its role in the application environment.
```


## Configuration Files Explained

1. main.tf:

This file defines the main resources for your AWS infrastructure, including the VPC, subnets, security groups, EC2 instances, Application Load Balancer, and Route 53 records.

2. provider.tf:

This file specifies the provider configuration for AWS, including the required provider version and region.

3. variable.tf:

This file contains the variable definitions used in the Terraform configuration. Variables are used to parameterize the configuration, making it more flexible and reusable.

4. userdata1.sh and userdata2.sh:

These files contain the user data scripts that will be executed on the EC2 instances at launch. These scripts typically include commands to configure the instances, install software, and set up the application environment.


## Changes to Enable HTTPS
### Create an SSL Certificate using AWS Certificate Manager (ACM):

* Navigate to the AWS Certificate Manager (ACM) Console.
* Request a public certificate for your domain.
* Choose DNS validation and add the provided CNAME record to Route 53.
* ACM will validate the certificate once the DNS record is in place.
**Update the Terraform Configuration for HTTPS:** Add the ACM certificate ARN to your variable.tf file.

**Update main.tf to include an HTTPS listener on the ALB:**
```
resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.mylb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.acm_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.mytg.arn
  }
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.mylb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
```

**Apply the Updated Configuration:**

Run **terraform apply** to update the infrastructure with the HTTPS configuration. This will set up the ALB to use the SSL certificate for secure communication.