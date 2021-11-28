terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

provider "docker" {
  host = var.docker-api
}

resource "docker_network" "network" {
  name = "data-pipeline"
}

module "zookeeper" {
  source       = "./modules/zookeeper"
  count        = length(var.zookeeper-nodes)
  index        = count.index
  port         = var.zookeeper-nodes[count.index]
  network-name = docker_network.network.name
}

module "kafka" {
  source = "./modules/kafka"
  depends_on = [
    module.zookeeper
  ]
  count             = length(var.kafka-nodes)
  port              = var.kafka-nodes[count.index]
  index             = count.index
  zookeeper-servers = join(",", [for n in module.zookeeper : n.url])
  network-name      = docker_network.network.name
}

module "flink" {
  source = "./modules/flink"
  depends_on = [
    module.kafka
  ]
  workers      = 2
  network-name = docker_network.network.name
  session-name = "flink"
}
