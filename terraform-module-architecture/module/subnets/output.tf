output "subnet_created" {
  description = "Output of all subnets created"
  value = {
    for k, v in aws_subnet.use1 :
    k => {
      arn                       = v.arn
      id                        = v.id
      availability_zone         = v.availability_zone
      availability_zone_id      = v.availability_zone_id
      cidr_block                = v.cidr_block
      map_public_ip_on_launch   = v.map_public_ip_on_launch
      owner_id                  = v.owner_id
      tags_all                  = v.tags_all
    }
  } 
}