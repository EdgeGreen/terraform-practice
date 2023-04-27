# resource "aws_vpc" "main" {
#   cidr_block       = "10.0.0.0/16"
#   instance_tenancy = "default"
#   enable_dns_hostnames = true
#   enable_dns_support   = true
# }

# resource "aws_subnet" "private" {
#   vpc_id     = aws_vpc.main.id
#   cidr_block = "10.0.10.0/24"
#   map_public_ip_on_launch = false

# }

# resource "aws_route_table" "private" {
#   vpc_id = aws_vpc.main.id
#   route = []
# }

# resource "aws_route_table_association" "private_subnet_association" {
#   subnet_id = aws_subnet.private.id
#   route_table_id = aws_route_table.private.id
# }

# resource "aws_security_group" "vpc_endpoint_sg" {
#   name_prefix = "vpc-endpoint-sg-"

#   ingress {
#     from_port = 0
#     to_port = 0
#     protocol = "-1"
#     cidr_blocks = ["10.0.0.0/16"]
#   }
# }

# resource "aws_vpc_endpoint" "s3_endpoint" {
#   vpc_id = aws_vpc.main.id
#   service_name = "com.amazonaws.eu-central-1.s3"
#   # vpc_endpoint_type = "Interface"
#   route_table_ids = [aws_route_table.private.id]
#   # security_group_ids = [aws_security_group.vpc_endpoint_sg.id]
#   # private_dns_enabled = true
#   policy = <<POLICY
# {
#     "Statement": [
#         {
#             "Action": "s3:*",
#             "Effect": "Allow",
#             "Resource": ["${aws_s3_bucket.info_bucket.arn}",
#                    "${aws_s3_bucket.info_bucket.arn}/*"],
#             "Principal": "*"
#         }
#     ]
# }
# POLICY
# }

