resource "random_id" "vpc_name" {
  byte_length = 4
}

resource "ibm_is_vpc" "vpc1" {
  name = "${random_id.vpc_name.hex}-vpc"
}

resource "ibm_is_instance" "z1_instance1" {
  name    = "z1-instance1"
  image   = var.image
  profile = var.profile

  primary_network_interface {
    subnet = ibm_is_subnet.z1_subnet1.id
  }

  vpc       = ibm_is_vpc.vpc1.id
  zone      = var.zone1
  keys      = [data.ibm_is_ssh_key.vpc_us_south_key.id]
  user_data = file("nginx.sh")
}

resource "ibm_is_instance" "z2_instance1" {
  name    = "z2-instance1"
  image   = var.image
  profile = var.profile

  primary_network_interface {
    subnet = ibm_is_subnet.z2_subnet1.id
  }

  vpc       = ibm_is_vpc.vpc1.id
  zone      = var.zone2
  keys      = [data.ibm_is_ssh_key.vpc_us_south_key.id]
  user_data = file("nginx.sh")
}

resource "ibm_is_volume" "z1_vol1" {
  name     = "z1-vol1"
  profile  = "custom"
  zone     = var.zone1
  iops     = 1000
  capacity = 20
}


