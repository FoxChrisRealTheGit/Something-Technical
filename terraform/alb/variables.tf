#################################################
# LOCALS
#################################################

variable "tags" {
  default     = {}
  description = "Tags merged that are bubbling down"
  type        = map(string)
}

#################################################
# INPUTS
#################################################

# this is the input parameter of the module
variable "vpc_id" {}

variable "subnets" {}

variable "cidr_blocks" {}

variable "vpc_security_group" {}
