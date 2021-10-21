resource "aws_instance" "Challenge2021" {
   ami = "${var.ami}"
   instance_type = "${var.instancetype}"
   subnet_id = "${var.subnet_1a}"
   vpc_security_group_ids = ["${aws_security_group.ec2-sg.id}"]
   tags = {
      Name = "${var.dev}.${var.ops}"
    }
   user_data = <<-EOF

   #!/bin/bash
   sudo yum update -y
   sudo yum install docker -y
   sudo service docker start
   sudo systemctl enable docker
   docker pull nginx
   docker run -itd --name=challenge -p 80:80 nginx
   EOF
 }
resource "aws_security_group" "ec2-sg" {
      name   = "${var.dev}.${var.ops}-sg"
      vpc_id = "vpc-db83f6b0"

      ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
      egress {
       from_port   = 0
       to_port     = 0
       protocol    = "-1"
       cidr_blocks = ["0.0.0.0/0"]
    }
  }
