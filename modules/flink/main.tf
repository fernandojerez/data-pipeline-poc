terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

resource "docker_image" "flink" {
  name         = "flink:latest"
  keep_locally = true
}

resource "docker_container" "session" {
  name    = var.session-name
  image   = docker_image.flink.latest
  env     = ["FLINK_PROPERTIES=jobmanager.rpc.address: ${var.session-name}"]
  command = ["jobmanager"]
  ports {
    internal = 8081
    external = var.session-port
  }
  networks_advanced {
    name = var.network-name
  }
}

resource "docker_container" "taskmanager" {
  count = var.workers
  depends_on = [
    docker_container.session
  ]
  image = docker_image.flink.latest
  name  = "${var.session-name}-worker-${count.index}"
  env = [<<-EOT
        FLINK_PROPERTIES=
        jobmanager.rpc.address: ${var.session-name}
        taskmanager.numberOfTaskSlots: 2  
        EOT
  ]
  command = ["taskmanager"]
  networks_advanced {
    name = var.network-name
  }
}
