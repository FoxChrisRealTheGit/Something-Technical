#################################################
# GLOBALS
#################################################

variable "tags" {
  default     = {}
  description = "Global tags for all resources"
  type        = map(string)
}

#################################################
# INPUT
#################################################

# this is the input parameter of the module
variable "name" {}

variable "cidr" {}

variable "azs" {}

variable "private_subnets" {}

variable "public_subnets" {}

variable "enable_nat_gateway" {}

variable "single_nat_gateway" {}

variable "enable_vpn_gateway" {}
