variable "aws_region" {}
variable "vpc_details" {
  type = map(object({

    cidr_block = string
    name = string
    prefix = string 
    instance_tenancy = optional(string)
    enable_dns_hostname = optional(bool)
    enable_dns_support = optional(bool)
    tags = optional(map(string))

  }))
}