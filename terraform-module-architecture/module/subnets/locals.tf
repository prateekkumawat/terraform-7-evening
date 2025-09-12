locals {
  subnet_blocks = { 
    for k,v in var.subnet_details : 
    k => {
      cidr_block              = v.cidr_block
      avaibility_zone         = v.avaibility_zone
      vpc_id                  = v.vpc_id
      map_public_ip_on_launch = v.map_public_ip_on_launch=="" ? "false" : v.map_public_ip_on_launch
      tags                    = merge(v.tags , v.prefix == null ? tomap({ Name: "${v.Name}"}): tomap({ Name: "${v.prefix}-${v.Name}"}))
    } 
  }
}