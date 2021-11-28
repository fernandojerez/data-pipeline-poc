variable "port" {
  type        = number
  description = "Exposed port"
}

variable "index" {
  type        = number
  description = "Node index"
}

variable "zookeeper-servers" {
  type        = string
  description = "Zookeeper servers"
}

variable "network-name" {
  type        = string
  description = "Network name"
}
