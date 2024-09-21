resource "aws_nat_gateway" "nat-GW" {
  allocation_id = aws_eip.nat-eip.id
  subnet_id     = aws_subnet.public-sub2.id

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_eip" "nat-eip" {
  tags = {
    Name = "nat-eip"
  }
}
