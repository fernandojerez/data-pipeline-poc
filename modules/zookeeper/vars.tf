variable "internal-port" {
  type        = number
  description = "Internal port"
  default     = 2181
}

variable "tick-time" {
  type        = number
  description = "Tick time in milliseconds"
  default     = 2000
}

variable "index" {
  type        = number
  description = "Node index"
}

variable "network-name" {
  type        = string
  description = "Network name"
}

variable "port" {
  type        = number
  description = "Exposed port"
}
