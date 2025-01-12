variable "project_id" {
  type        = string
  description = "ID of the GCP project"
}

variable "gcp_region" {
  type        = string
  description = "GCP region to use for resources"
  default     = "europe-central2"
}

variable "gcp_zone" {
  type        = string
  description = "GCP zone to use for resources"
  default     = "europe-central2-b"
}