data "ibm_resource_group" "group" {
  name = "default"
}

data "ibm_is_ssh_key" "vpc_us_south_key" {
    name = var.ssh_key_name
}