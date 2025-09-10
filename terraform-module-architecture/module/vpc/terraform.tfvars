vpc_details = {
  "pp" = {
    name = "pp"
    prefix = "hsit-use1"
    cidr_block = "10.0.0.0/16"
    tags = {
        createdby = "terraform"
        cost_id   = "pp-client"
        infra     = "pp"
        developed = "ops-team"
        managed   = "cloud-team"
    }
  }

  "prod" = {
    name = "prod"
    prefix = "hsit-use1"
    cidr_block = "10.0.0.0/16"
    tags = {
        createdby = "terraform"
        cost_id   = "prod-client"
        infra     = "prod"
        developed = "ops-team"
        managed   = "cloud-team"
    }
  } 
}