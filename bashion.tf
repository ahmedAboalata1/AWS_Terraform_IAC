resource "aws_instance" "bashion" {
  ami                         = "ami-0ebfd941bbafe70c6"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public-sub1.id
  associate_public_ip_address = true
  availability_zone           = "us-east-1a"
  security_groups             = [aws_security_group.bashion.id]
  tags = {
    Name = "bashion-host"
  }
  key_name = "project"
}
