output "vpc_id" {
  value = ibm_is_vpc.vpc1.id
}

output "lb_url" {
  value = ibm_is_lb.webserver_lb.hostname
}

output "cse_source_addresses" {
  value = ibm_is_vpc.vpc1.cse_source_addresses
}

# output "cse_source" {
#   value = ibm_is_vpc.vpc1.cse_source
# }

output "z1_pgw_fip" {
  value = ibm_is_public_gateway.z1_pgw.floating_ip
}