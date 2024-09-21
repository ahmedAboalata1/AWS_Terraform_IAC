resource "aws_security_group" "HTTP-SG" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }
  ingress {
    cidr_blocks= ["0.0.0.0/0"]
    from_port  = 22
    protocol   = "tcp"
    to_port    = 22
  }
  egress {
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
    protocol = -1
  }
  tags={
    Name="HTTP-SG"
  }
}

resource "aws_security_group" "bashion" {
  vpc_id = aws_vpc.vpc.id
    ingress {
    cidr_blocks= ["0.0.0.0/0"]
    from_port  = 22
    protocol   = "tcp"
    to_port    = 22
  }
    egress {
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
    protocol = -1
  }
}




