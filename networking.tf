resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "bg-igw"
  }
}

#route_table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

#route_table_association
#blue-subnet
resource "aws_route_table_association" "blue_assoc" {
  subnet_id      = aws_subnet.blue_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

#green_subnet
resource "aws_route_table_association" "green_assoc" {
  subnet_id      = aws_subnet.green_subnet.id
  route_table_id = aws_route_table.public_rt.id
}