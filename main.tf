provider "kind" {}

resource "kind_cluster" "this" {
  name = "flux-e2e"
}

provider "github" {
  owner = var.github_org
  token = var.github_token
}

resource "tls_private_key" "flux" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "github_repository_deploy_key" "this" {
  title      = "Flux"
  repository = var.github_repository
  key        = tls_private_key.flux.public_key_openssh
  read_only  = "false"
}

provider "flux" {
  kubernetes = {
    host                   = kind_cluster.this.endpoint
    client_certificate     = kind_cluster.this.client_certificate
    client_key             = kind_cluster.this.client_key
    cluster_ca_certificate = kind_cluster.this.cluster_ca_certificate
  }
  git = {
    url = "ssh://git@github.com/${var.github_org}/${var.github_repository}.git"
    ssh = {
      username    = "git"
      private_key = tls_private_key.flux.private_key_pem
    }
  }
}

output "host" {
  value = kind_cluster.this.endpoint
}
output "client_certificate" {
  value = kind_cluster.this.client_certificate
}
output "client_key" {
  value = kind_cluster.this.client_key
}
output "cluster_ca_certificate" {
  value = kind_cluster.this.cluster_ca_certificate
}


resource "flux_bootstrap_git" "this" {
  # depends_on = [github_repository_deploy_key.this]

  # path = "clusters/my-cluster"
}