
#################################################
# INPUTS
#################################################

variable "tags" {
  default     = {}
  description = "Tags bubbling down"
  type        = map(string)
}

