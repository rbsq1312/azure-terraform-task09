locals {
  pip_name         = "${var.unique_id}-pip"
  firewall_name    = "${var.unique_id}-afw"
  route_table_name = "${var.unique_id}-rt"
  
  # Rule collection priorities
  nat_rule_priority     = 100
  network_rule_priority = 200
  app_rule_priority     = 300
}
