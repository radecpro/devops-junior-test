terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
    random = {
      source = "hashicorp/random"
    }
  }
  backend "gcs" {
    bucket = "bara-tfstate"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = var.project_id
  region  = var.gcp_region
  zone    = var.gcp_zone
}

provider "random" {
  # Configuration options
}

locals {
  naming_prefix = "bara"
  common_tags = {
    owner = "bara"
  }
}