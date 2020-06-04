data "ibm_resource_group" "group" {
  name = var.resource_group
}

data "ibm_is_ssh_key" "vpc_us_south_key" {
  name = var.ssh_key_name
}