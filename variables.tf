variable "project_id" {
  type = string
}

variable "name" {
  type    = string
  default = "github"
}

variable "zone" {
  type = string
}

variable "machine_type" {
  type    = string
  default = "e2-highmem-4"
}

variable "boot_disk_type" {
  type    = string
  default = "pd-standard"
}

variable "boot_disk_image" {
  type    = string
  default = "github-enterprise-public/github-enterprise-3-4-2"
}

variable "service_account_scopes" {
  type    = list(string)
  default = ["cloud-platform"]
}

variable "tags" {
  type    = list(string)
  default = ["github"]
}

variable "network" {
  type    = string
  default = "default"
}

variable "attached_storage_name" {
  type    = string
  default = "attached-storage"
}

variable "attached_storage_size" {
  type    = number
  default = 150
}

variable "attached_storage_type" {
  type    = string
  default = "pd-standard"
}
