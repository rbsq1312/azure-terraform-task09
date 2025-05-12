locals {
  pip_name         = "${var.unique_id}-pip"
  firewall_name    = "${var.unique_id}-afw"
  route_table_name = "${var.unique_id}-rt"

  # Rule collection priorities and names
  rule_collections = {
    nat = {
      name     = "${var.unique_id}-nat-rules"
      priority = 100
      action   = "Dnat"
    }
    network = {
      name     = "${var.unique_id}-network-rules"
      priority = 200
      action   = "Allow"
    }
    application = {
      name     = "${var.unique_id}-app-rules"
      priority = 300
      action   = "Allow"
    }
  }

  # NAT rules
  nat_rules = [
    {
      name              = "AllowInboundHTTP"
      source_addresses  = ["*"]
      destination_ports = ["80"]
      protocols         = ["TCP"]
      translated_port   = "80"
    },
    {
      name              = "AllowInboundHTTPS"
      source_addresses  = ["*"]
      destination_ports = ["443"]
      protocols         = ["TCP"]
      translated_port   = "443"
    }
  ]

  # Network rules
  network_rules = [
    {
      name                  = "AllowDNS"
      source_addresses      = ["*"]
      destination_addresses = ["*"]
      destination_ports     = ["53"]
      protocols             = ["UDP", "TCP"]
    },
    {
      name                  = "AllowAzureCloud"
      source_addresses      = ["*"]
      destination_addresses = ["AzureCloud"]
      destination_ports     = ["*"]
      protocols             = ["Any"]
    },
    {
      name                  = "AllowInternetOutbound"
      source_addresses      = ["*"]
      destination_addresses = ["*"]
      destination_ports     = ["*"]
      protocols             = ["TCP"]
    }
  ]

  # App rule FQDNs
  app_rule_fqdns = [
    "*.aks-ingress.microsoft.com",
    "*.aks.microsoft.com",
    "*.login.microsoft.com",
    "*.monitoring.azure.com",
    "*.azurecr.io",
    "*.blob.core.windows.net",
    "mcr.microsoft.com",
    "*.cdn.mscr.io",
    "management.azure.com",
    "login.microsoftonline.com",
    "*.kubernetes.io"
  ]
}
