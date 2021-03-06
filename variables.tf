#######################
### GCP CREDENTIALS ###
#######################

variable "project_id" {
  type        = string
  description = "Google Cloud project ID to deploy resources into"
}

variable "region" {
  type        = string
  description = "Region to deploy resources into"
  default     = "europe-west1"
}

###########
### GKE ###
###########

variable "gke_num_nodes" {
  type        = number
  description = "Number of GKE cluster nodes"
  default     = 1
}

variable "gke_zone" {
  type        = string
  description = "Zone of the GKE cluster"
  default     = "europe-west1-b"
}
