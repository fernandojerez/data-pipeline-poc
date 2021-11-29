terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

resource "docker_image" "postgresql" {
  name         = "postgres:latest"
  keep_locally = true
}

resource "docker_container" "postgresql" {
  name  = "postgresql"
  image = docker_image.postgresql.latest
  env = [
    "POSTGRES_PASSWORD=${var.database-password}",
    "POSTGRES_USER=${var.database-user}",
    "POSTGRES_DB=${var.database-name}"
  ]
  ports {
    internal = var.port
    external = var.port
  }
  networks_advanced {
    name = var.network-name
  }
}
