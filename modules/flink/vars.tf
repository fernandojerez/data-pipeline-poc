variable "workers" {
  type        = number
  description = "number of taskmanagers"
}

variable "network-name" {
  type        = string
  description = "network name"
}

variable "session-port" {
  type        = number
  description = "session port"
  default     = 8081
}

variable "session-name" {
  type        = string
  description = "session name"
  default     = "jobmanager"
}
