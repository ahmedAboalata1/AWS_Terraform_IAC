resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "igw"
  }
}
resource "aws_route_table" "publicRT" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "publicRT"
  }
}
resource "aws_route_table" "privateRT" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "privateRT"
  }
}
resource "aws_route" "privateR" {
  route_table_id         = aws_route_table.privateRT.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat-GW.id
}
resource "aws_route_table_association" "association-private1" {
  route_table_id = aws_route_table.privateRT.id
  subnet_id      = aws_subnet.private-sub1.id
}
resource "aws_route_table_association" "association-private2" {
  route_table_id = aws_route_table.privateRT.id
  subnet_id      = aws_subnet.private-sub2.id
}
resource "aws_route_table_association" "association-public1" {
  route_table_id = aws_route_table.publicRT.id
  subnet_id      = aws_subnet.public-sub1.id
}
resource "aws_route_table_association" "association-public2" {
  route_table_id = aws_route_table.publicRT.id
  subnet_id      = aws_subnet.public-sub2.id
}
