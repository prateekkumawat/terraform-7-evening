# Terraform variables ::::
* - Data Types ::: programming lang what type data you provide system understand through data types
- int 
- float
- dacimal 
- imageniry 1 + i3 
- string 
- list 
- tuple 
- dictionary 

-- string "prateek" , "abc", "10.0.0.0/24", "i-123435645" 
number --- 
list  ---- [ "collection", "test", "list"]  --- index number 
map ----    { key1---> value1 collection  
boolen --- true/false ; yes/no 


varibles :::: that value we can change or its dynamic that change your output. { repetation of  code }

variables.tf 
variable "variable_name" {
    type = string 
    default = "xyz"
    description = "purpose of usages" 
}

terraform plan/apply -var="var_name=value" // -var-file="filename.tfvars" 
varfiles == terraform.tfvars // any name 