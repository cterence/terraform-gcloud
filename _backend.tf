terraform {
  backend "local" {
    path = "./_state/terraform.tfstate"
  }
}
