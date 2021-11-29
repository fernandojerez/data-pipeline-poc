variable "zookeeper-nodes" {
  type        = list(number)
  description = "Define zookeeper nodes with an unique port (value) for each one"
  default     = [22181, 32181]
}

variable "kafka-nodes" {
  type        = list(number)
  description = "Define kafka nodes with an unique port (value) for each one"
  default     = [29092, 39092]
}

variable "docker-api" {
  type        = string
  default     = "npipe:////./pipe/docker_engine"
  description = "Docker api url"
}

variable "database" {
  type = map(string)
  default = {
    name     = "store"
    user     = "pipeline"
    password = "Password1$"
  }
  description = "database configuration"
}
