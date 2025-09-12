variable "subnet_details" {
    type = map(object({
        cidr_block       = string
        avaibility_zone  = string
        prefix             = string
        map_public_ip_on_launch = optional(bool)
        tags             = map(string)
        vpc_id           = string
        Name             = string
    }))
}