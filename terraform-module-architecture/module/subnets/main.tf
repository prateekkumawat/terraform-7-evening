resource "aws_subnet" "use1" {
  for_each = local.subnet_blocks
  vpc_id                = each.value.vpc_id   
  cidr_block            = each.value.cidr_block 
  availability_zone     = each.value.avaibility_zone 
  tags                  = each.value.tags
  map_public_ip_on_launch = each.value.map_public_ip_on_launch
}