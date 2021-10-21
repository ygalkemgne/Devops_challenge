resource "aws_instance" "Challenge2021" {
   ami = "${var.ami}"
   instance_type = "${var.instancetype}"
   subnet_id = "${var.subnet_1a}"
   vpc_security_group_ids = ["${aws_security_group.ec2-sg.id}"]
   user_data = <<-EOF
   #!/bin/bash
yum update -y
amazon-linux-extras install nginx1.12
nginx -v
systemctl start nginx
systemctl enable nginx
chmod 2775 /usr/share/nginx/html
find /usr/share/nginx/html -type d -exec chmod 2775 {} \;
find /usr/share/nginx/html -type f -exec chmod 0664 {} \;
EOF

  tags = {
     Name = "${var.dev}.${var.ops}"
   }
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
