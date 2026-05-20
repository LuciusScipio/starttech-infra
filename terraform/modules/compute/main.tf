data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_iam_role" "ec2_role" {
  name = "starttech-ec2-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{ Action = "sts:AssumeRole", Effect = "Allow", Principal = { Service = "ec2.amazonaws.com" } }]
  })
}

resource "aws_iam_role_policy_attachment" "cloudwatch_access" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_instance_profile" "profile" {
  name = "starttech-ec2-profile"
  role = aws_iam_role.ec2_role.name
}

resource "aws_launch_template" "backend" {
  name_prefix   = "backend-lt-"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  
  iam_instance_profile { name = aws_iam_instance_profile.profile.name }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [var.backend_sg_id]
  }
}

resource "aws_autoscaling_group" "backend" {
  desired_capacity    = 2
  max_size            = 4
  min_size            = 1
  target_group_arns   = [var.target_group_arn]
  vpc_zone_identifier = var.public_subnets

  launch_template {
    id      = aws_launch_template.backend.id
    version = "$Latest"
  }
}