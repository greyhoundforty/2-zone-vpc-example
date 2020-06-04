resource "ibm_is_subnet" "z1_subnet1" {
  name            = "z1-subnet1"
  vpc             = ibm_is_vpc.vpc1.id
  zone            = var.zone1
  ipv4_cidr_block = "10.240.0.0/28"
}

resource "ibm_is_subnet" "z2_subnet1" {
  name            = "z2-subnet1"
  vpc             = ibm_is_vpc.vpc1.id
  zone            = var.zone2
  ipv4_cidr_block = "10.240.64.0/28"
}

resource "ibm_is_floating_ip" "z1_instance1_fip" {
  name   = "z1-instance1-fip"
  target = ibm_is_instance.z1_instance1.primary_network_interface[0].id
}

resource "ibm_is_public_gateway" "z1_pgw" {
  name = "z1-pgw"
  vpc  = ibm_is_vpc.vpc1.id
  zone = var.zone1
}

resource "ibm_is_lb" "webserver_lb" {
  name    = "web-lb"
  subnets = [ibm_is_subnet.z1_subnet1.id]
}


resource "ibm_is_lb_pool" "web_pool" {
  name           = "web-pool"
  lb             = ibm_is_lb.webserver_lb.id
  algorithm      = "round_robin"
  protocol       = "http"
  health_delay   = 60
  health_retries = 5
  health_timeout = 30
  health_type    = "http"
}

resource "ibm_is_lb_pool_member" "z1_member" {
  lb             = ibm_is_lb.webserver_lb.id
  pool           = ibm_is_lb_pool.web_pool.id
  port           = 80
  target_address = ibm_is_instance.z1_instance1.primary_network_interface.primary_ipv4_address
  weight         = 60
}

resource "ibm_is_lb_pool_member" "z2_member" {
  lb             = ibm_is_lb.webserver_lb.id
  pool           = ibm_is_lb_pool.web_pool.id
  port           = 80
  target_address = ibm_is_instance.z2_instance1.primary_network_interface.primary_ipv4_address
  weight         = 60
}