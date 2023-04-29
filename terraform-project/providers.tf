provider "google" {
  project     = "virtual-cycling-384917"
  region      = "us-central1"
  credentials = "./terraform-gke-keyfile.json"
}