#blue_env
resource "aws_instance" "blue" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.blue_subnet.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name               = var.key_name

  user_data = <<-EOF
            #!/bin/bash
            apt update -y
            apt install -y apache2

            cat <<EOT > /var/www/html/index.html
            ${file("blue.html")}
            EOT

            systemctl restart apache2
            systemctl enable apache2
            EOF

  tags = {
    Name = "Blue-Instance"
  }
}

#green_env
resource "aws_instance" "green" {
  ami                    = "ami-0ec10929233384c7f"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.green_subnet.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name               = "dd-key"

  user_data = <<-EOF
            #!/bin/bash
            apt update -y
            apt install -y apache2

            cat <<EOT > /var/www/html/index.html
            ${file("green.html")}
            EOT

            systemctl restart apache2
            systemctl enable apache2
            EOF

  tags = {
    Name = "Green-Instance"
  }
}