#####################################
#             default               #
#####################################
variable "region"{
    description = "AWS Region"
    type = string
    default = "ap-northeast-2"
}

variable "key_name"{
    description = "EC2 key name"
    type = string
    default = "jt-play" #modify
}


#####################################
#               Tag                 #
#####################################
variable "company"{
    default = "isnt"
}
variable "env"{
    default = "DEV"
}

#####################################
#               VPC                 #
#####################################
variable "vpc_cidr"{
    type = string
    default = "10.50.0.0/16" #modify
}


locals {
  public-subnets = [
    {
      zone = "${var.region}a" ## Must be put a AZs alphabet
      cidr = "10.50.0.0/24"
    }, 
    {
      zone = "${var.region}c"
      cidr = "10.50.1.0/24"
    }
  ]
  web-subnets = [
    {
      purpose = "pri-web"
      zone = "${var.region}a"
      cidr = "10.50.10.0/24"
    },
    {
      purpose = "pri-web"
      zone = "${var.region}c"
      cidr = "10.50.11.0/24"
    },
  ]
  db-subnets = [
    {
      purpose = "pri-db"
      zone = "${var.region}a"
      cidr = "10.50.20.0/24"
    },
    {
      purpose = "pri-db"
      zone = "${var.region}c"
      cidr = "10.50.21.0/24"
    }
  ]
    test-subnets = [
    {
      purpose = "pri-db"
      zone = "${var.region}a"
      cidr = "10.50.200.0/24"
    },
    {
      purpose = "pri-db"
      zone = "${var.region}c"
      cidr = "10.50.201.0/24"
    }
  ]
}

#####################################
#               EC2                 #
#####################################


