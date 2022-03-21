provider "google" {
  project = var.ProjectID
  region  = var.DefaultRegion
  zone    = var.DefaultZone
  #credentials = "../dev-project-344105-80dace42be04.json"
}


# provider "google-beta" {
#   project = var.ProjectID
#   region  = var.DefaultRegion
#   zone    = var.DefaultZone
#   #credentials = "../dev-project-344105-80dace42be04.json"
# }




# resource "google_compute_network" "vpc_network" {
#   name                    = "terraform-network"
#   auto_create_subnetworks = "true"
# }




# data "google_compute_image" "my_image" {
#   family  = "debian-9"
#   project = "debian-cloud"
# }

# resource "google_compute_disk" "foobar" {
#   name  = "existing-disk"
#   image = data.google_compute_image.my_image.self_link
#   size  = 10
#   type  = "pd-ssd"
#   zone  = "us-central1-a"
# }



# module "vpc" {
#   source  = "terraform-google-modules/network/google"
#   version = "~> 4.0"


#   project_id   = var.ProjectID
#   network_name = "testingmodule"
#   routing_mode = "GLOBAL"

#   subnets = [
#     {
#       subnet_name   = "subnet-01"
#       subnet_ip     = "10.10.10.0/24"
#       subnet_region = "us-west1"
#     },
#     {
#       subnet_name           = "subnet-02"
#       subnet_ip             = "10.10.20.0/24"
#       subnet_region         = "us-west1"
#       subnet_private_access = "true"
#       subnet_flow_logs      = "true"
#       description           = "This subnet has a description"
#     },
#     {
#       subnet_name               = "subnet-03"
#       subnet_ip                 = "10.10.30.0/24"
#       subnet_region             = "us-west1"
#       subnet_flow_logs          = "true"
#       subnet_flow_logs_interval = "INTERVAL_10_MIN"
#       subnet_flow_logs_sampling = 0.7
#       subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
#     }
#   ]

#   secondary_ranges = {
#     subnet-01 = [
#       {
#         range_name    = "subnet-01-secondary-01"
#         ip_cidr_range = "192.168.64.0/24"
#       },
#     ]

#     subnet-02 = []
#   }

#   # routes = [
#   #     {
#   #         name                   = "egress-internet"
#   #         description            = "route through IGW to access internet"
#   #         destination_range      = "0.0.0.0/0"
#   #         tags                   = "egress-inet"
#   #         next_hop_internet      = "true"
#   #     },
#   #     {
#   #         name                   = "app-proxy"
#   #         description            = "route through proxy to reach app"
#   #         destination_range      = "10.50.10.0/24"
#   #         tags                   = "app-proxy"
#   #         next_hop_instance      = "app-proxy-instance"
#   #         next_hop_instance_zone = "us-west1-a"
#   #     },
#   # ]
# }

resource "google_compute_network" "vpc_network" {
  project                 = var.ProjectID
  name                    = "vpc-network"
  auto_create_subnetworks = true
  mtu                     = 1460
}
# output "new-networkname" {
#   value = module.vpc.network_name
# }
# output "network_id" {
#   value = module.vpc.network_id
# }



