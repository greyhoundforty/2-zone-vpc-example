variable "zone1" {
  type        = string
  description = "Zone 1 in us-south VPC region"
  default     = "us-south-1"
}

variable "zone2" {
  type        = string
  description = "Zone 2 in us-south VPC region"
  default     = "us-south-2"
}

variable "ssh_public_key" {
  type        = string
  description = "SSH Key that gets added to deployed instances"
  default     = ""
}

variable "image" {
  type        = string
  description = "Default OS Image for systems. This is set to the latest Ubuntu 64 image in the catalog"
  default     = "r006-14140f94-fcc4-11e9-96e7-a72723715315"
}

variable "profile" {
  type        = string
  description = "Default instance profile."
  default     = "bx2-2x8"
}

