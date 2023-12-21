resource "yandex_compute_disk" "empty_disk" {
  count = var.name_count_disk
  name  = "disk-${count.index + 1}"
  type       = "network-hdd"
  zone       = var.default_zone
  size       = 1
  block_size = 4096
}

resource "yandex_compute_instance" "st" {
  depends_on = [yandex_compute_disk.empty_disk]
  count = var.name_count_st
  name        = var.st_name
  platform_id = var.vm_web_platform_id
  resources {
    cores         = var.vms_resource.db.core
    memory        = var.vms_resource.db.memory
    core_fraction = var.vms_resource.db.fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.empty_disk
    content {
      disk_id = lookup(secondary_disk.value,"id")
      auto_delete = true
    }
  }
  scheduling_policy {
    preemptible = var.vm_db_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_db_nat
  }

  metadata = {
    serial-port-enable = var.metadata
    ssh-keys           = "ubuntu:${local.ssh}"
  }
}