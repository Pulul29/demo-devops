terraform {
  backend "gcs" {
    bucket      = "terraform-gke-psaluisa"
    prefix      = "terraform/state"
    credentials = "./terraform-gke-keyfile.json"
  }
}