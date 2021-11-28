terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

resource "docker_image" "kafka" {
  name         = "confluentinc/cp-kafka:latest"
  keep_locally = true
}

resource "docker_container" "kafka" {
  name     = "kafka-${var.index}"
  hostname = "kafka-${var.index}"
  image    = docker_image.kafka.latest
  env = [
    "KAFKA_BROKER_ID=${var.index}",
    "KAFKA_ZOOKEEPER_CONNECT=${var.zookeeper-servers}",
    "KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://kafka-${var.index}:9092,PLAINTEXT_HOST://localhost:${var.port}",
    "KAFKA_LISTENER_SECURITY_PROTOCOL_MAP=PLAINTEXT:PLAINTEXT,PLAINTEXT_HOST:PLAINTEXT",
    "KAFKA_INTER_BROKER_LISTENER_NAME=PLAINTEXT",
    "KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR=1"
  ]
  ports {
    internal = var.port
    external = var.port
  }
  networks_advanced {
    name = var.network-name
  }
}
