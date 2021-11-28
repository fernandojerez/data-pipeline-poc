terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

resource "docker_image" "zookeeper" {
  name         = "confluentinc/cp-zookeeper:latest"
  keep_locally = true
}

resource "docker_container" "zookeeper" {
  name     = "zookeeper-${var.index}"
  hostname = "zookeeper-${var.index}"
  image    = docker_image.zookeeper.latest
  env = [
    "ZOOKEEPER_CLIENT_PORT=${var.internal-port}",
    "ZOOKEEPER_TICK_TIME=${var.tick-time}"
  ]
  ports {
    internal = var.internal-port
    external = var.port
  }
  networks_advanced {
    name = var.network-name
  }
}
