###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}


variable "name_count" {
  type = number
  default = 2
}


variable "each_vm" {
    description = "for_each_vm"
    type = list(object(
      {
        vm_name = string
        cores = number
        memmory = number
        core_fraction = number
      }))
      default = [ {
        vm_name = "main"
        cores = 2
        memmory = 1
        core_fraction = 5
      },
      {
        vm_name = "replica"
        cores = 4
        memmory = 2
        core_fraction = 20
      },
      ]
}

variable "metadata" {
  type = number
  default = 1
}

variable "name_count_disk" {
  type = number
  default = 3
}

variable "vm_web_platform_id" {
  type = string
  default = "standard-v1"
}

variable "vms_resource" {
  type = map
  default = {
    web = {
        core=2
        memory=1
        fraction=5
    }
    db = {
        core=2
        memory=2
        fraction=20
    }
  }
}

variable "vm_db_preemptible" {
  type = bool
  default = true
}

variable "vm_db_nat" {
  type = bool
  default = true
}

variable "st_name" {
  type = string
  default = "storage"
}

variable "name_count_st" {
  type = number
  default = 1
}

