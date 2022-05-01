#################################################
# GLOBALS
#################################################

variable "global_tags" {
  default     = {}
  description = "Global tags for all resources"
  type        = map(string)
}
