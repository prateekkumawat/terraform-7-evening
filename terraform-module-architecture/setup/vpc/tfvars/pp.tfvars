aws_region = "ap-south-1"
vpc_details = {
  "pp" = {
    name = "pp"
    prefix = "highsky-use1"
    cidr_block = "10.10.0.0/16"
    tags = {
        createdby = "terraform"
        cost_id   = "pp-client"
        infra     = "pp"
        developed = "ops-team"
        managed   = "cloud-team"
    }
  } 
}