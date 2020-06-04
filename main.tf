resource "random_id" "vpc_name" {
  byte_length = 2
}

resource "ibm_is_vpc" "vpc1" {
  name           = "vpc-${random_id.vpc_name.hex}"
  resource_group = data.ibm_resource_group.group.id
  tags           = ["ryantiffany"]
}

resource "ibm_is_instance" "z1_instance1" {
  vpc            = ibm_is_vpc.vpc1.id
  zone           = var.zone1
  resource_group = data.ibm_resource_group.group.id
  name           = "z1-${random_id.vpc_name.hex}-1"
  image          = var.image
  profile        = var.profile
  keys           = [data.ibm_is_ssh_key.vpc_us_south_key.id]
  user_data      = file("nginx.sh")
  tags           = ["vpc-${random_id.vpc_name.hex}", "ryantiffany"]

  primary_network_interface {
    subnet = ibm_is_subnet.z1_subnet1.id
  }
}

resource "ibm_is_instance" "z2_instance1" {
  vpc            = ibm_is_vpc.vpc1.id
  zone           = var.zone2
  resource_group = data.ibm_resource_group.group.id
  name           = "z2-${random_id.vpc_name.hex}-1"
  image          = var.image
  profile        = var.profile
  keys           = [data.ibm_is_ssh_key.vpc_us_south_key.id]
  user_data      = file("nginx.sh")
  tags           = ["ryantiffany"]

  primary_network_interface {
    subnet = ibm_is_subnet.z2_subnet1.id
  }
}

resource "ibm_is_volume" "z1_vol1" {
  name           = "z1-${random_id.vpc_name.hex}-vol1"
  profile        = "custom"
  zone           = var.zone1
  iops           = 100
  capacity       = 20
  resource_group = data.ibm_resource_group.group.id
}


