#####################################################
#                                                   #
#                                                   #
#         V P C INSTANCE USING TERRAFORM            #
#                                                   #
#                                                   #
#####################################################

#I want to create an VPC instance
resource "aws_vpc" "myvpc" {
  #create IP range (65536 IP's)
  cidr_block = var.cidr
}

#Define required subnets
resource "aws_subnet" "sub1" {
  #create subnet under the created VPC
  vpc_id = aws_vpc.myvpc.id
  #within the vpc range creating subnet (256 ip)
  cidr_block              = var.subnet1_cidr
  availability_zone       = var.availability_zone1
  map_public_ip_on_launch = true
}

resource "aws_subnet" "sub2" {
  #create subnet under the created VPC
  vpc_id = aws_vpc.myvpc.id
  #within the vpc range creating subnet (256 ip)
  cidr_block              = var.subnet2_cidr
  availability_zone       = var.availability_zone2
  map_public_ip_on_launch = true
}

#create an internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id
}

#create a route table
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

#subnet1 association with route table
resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.sub1.id
  route_table_id = aws_route_table.rt.id
}

#subnet2 association with route table
resource "aws_route_table_association" "rta2" {
  subnet_id      = aws_subnet.sub2.id
  route_table_id = aws_route_table.rt.id
}

#####################################################
#                                                   #
#                                                   #
#        Security group USING TERRAFORM             #
#                                                   #
#                                                   #
#####################################################

#create a security group
resource "aws_security_group" "sg" {
  name_prefix = "websg"
  description = "Edit the inbound-ingress and outbound-egress rules in the sg"

  vpc_id = aws_vpc.myvpc.id

  #inbound rule - enable port 80
  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #inbound rule - enable port 22
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #create outbound rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Web-sg"
  }
}

#####################################################
#                                                   #
#                                                   #
#         S3 Bucket USING TERRAFORM                 #
#                                                   #
#                                                   #
#####################################################

resource "aws_s3_bucket" "example" {
  bucket = var.s3_bucket_name
}

#####################################################
#                                                   #
#                                                   #
#         EC2 Instance USING TERRAFORM              #
#                                                   #
#                                                   #
#####################################################

resource "aws_instance" "webserver1" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg.id]
  subnet_id              = aws_subnet.sub1.id
  user_data              = base64encode(file("userdata1.sh"))
}

resource "aws_instance" "webserver2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg.id]
  subnet_id              = aws_subnet.sub2.id
  user_data              = base64encode(file("userdata2.sh"))
}

#####################################################
#                                                   #
#                                                   #
#         ALB USING TERRAFORM                       #
#                                                   #
#                                                   #
#####################################################

resource "aws_lb" "mylb" {
  name               = "mylb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg.id]
  subnets            = [aws_subnet.sub1.id, aws_subnet.sub2.id]

  tags = {
    Name = "web"
    #Environment = "production"
  }
}

#####################################################
#                                                   #
#                                                   #
#         Target group USING TERRAFORM              #
#                                                   #
#                                                   #
#####################################################

resource "aws_lb_target_group" "mytg" {
  name     = "mytg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.myvpc.id

  health_check {
    path = "/"
    port = "traffic-port"
  }
}

#attach lb to first ec2 instance
resource "aws_lb_target_group_attachment" "attach1" {
  target_group_arn = aws_lb_target_group.mytg.arn
  target_id        = aws_instance.webserver1.id
  port             = 80
}

#attach lb to second ec2 instance
resource "aws_lb_target_group_attachment" "attach2" {
  target_group_arn = aws_lb_target_group.mytg.arn
  target_id        = aws_instance.webserver2.id
  port             = 80
}

#attach target group to lb
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.mylb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.mytg.arn
  }
}

#####################################################
#                                                   #
#                                                   #
#           ROUTE-53  USING TERRAFORM               #
#                                                   #
#                                                   #
#####################################################
#Add a Hosted Zone
resource "aws_route53_zone" "main" {
  name = var.domain_name
}

#Create an Alias Record
resource "aws_route53_record" "info" {
  zone_id = aws_route53_zone.main.zone_id
  name = "${var.subdomain}.${var.domain_name}"
  type = "A"

  alias {
    name = aws_lb.mylb.dns_name
    zone_id = aws_lb.mylb.zone_id
    evaluate_target_health = true
  }

}


#####################################################
#                                                   #
#                                                   #
#         print output USING TERRAFORM              #
#                                                   #
#                                                   #
#####################################################

output "loadbalancerdns" {
  value = "${var.subdomain}.${var.domain_name}"
}