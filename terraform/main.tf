# Security Group
resource "aws_security_group" "gitlab-sg" {
  name        = "gitlab-sg"
  description = "Allow TLS inbound traffic for GitLab"

  ingress{
    description = "HTTPS"
    from_port = 443
    to_port   = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress{
    description = "HTTP"
    from_port = 80
    to_port   = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress{
    description = "SSH"
    from_port = 22
    to_port   = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "gitlab-sg"
  }
}



# Setup Server
resource "aws_instance" "gitlab-server"{
    ami = var.ami
    instance_type = var.instance_type
    availability_zone = var.zone
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.gitlab-sg.id]

    root_block_device {
    volume_size = 50      
    volume_type = "gp2"
  }

   tags = {
    Name = "Gitlab-Server"
   } 
}

# Security Group
resource "aws_security_group" "gitlab-runner-sg" {
  name        = "gitlab-run-sg"
  description = "Allow TLS inbound traffic for GitLab Runner"

  ingress{
    description = "SSH"
    from_port = 22
    to_port   = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "gitlab-runner-sg"
  }
}

resource "aws_instance" "gitlab-runner"{
    ami = var.ami
    instance_type = "t2.medium"
    availability_zone = var.zone
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.gitlab-runner-sg.id]

    root_block_device {
    volume_size = 50      
    volume_type = "gp2"
  }

   tags = {
    Name = "st16-runner"
   } 
}

# Security Group
resource "aws_security_group" "deployment-server-sg" {
  name        = "deployment-server-sg"
  description = "Allow TLS inbound traffic for Deployment Server"

  ingress{
    description = "SSH"
    from_port = 22
    to_port   = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress{
    description = "HTTPS"
    from_port = 443
    to_port   = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress{
    description = "HTTP"
    from_port = 80
    to_port   = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "deployment-server-sg"
  }
}

resource "aws_instance" "deployment-server"{
    ami = var.ami
    instance_type = "t2.medium"
    availability_zone = var.zone
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.deployment-server-sg.id]

    root_block_device {
    volume_size = 50      
    volume_type = "gp2"
  }

   tags = {
    Name = "deployment-server"
   } 
}
