locals {
  vpc_blocks = { 
    for k, v in var.vpc_details: 
    k => {
       cidr_block          = v.cidr_block
       name                = v.name
       prefix              = v.prefix 
       instance_tenancy    = v.instance_tenancy
       enable_dns_hostname = v.enable_dns_hostname
       enable_dns_support  = v.enable_dns_support
       tags                = merge(v.tags, v.prefix == "null" ? tomap({Name = "${v.name}"}): tomap({Name = "${v.prefix}-${v.name}"}))
    }
   } 
}