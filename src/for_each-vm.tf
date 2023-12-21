resource "yandex_compute_instance" "db" {
    for_each = toset(keys({for k, v in var.each_vm : k => v}))
    name = var.each_vm[each.value]["vm_name"]
    resources {
        cores = var.each_vm[each.value]["cores"]
        memory = var.each_vm[each.value]["memmory"]
        core_fraction = var.each_vm[each.value]["core_fraction"]
    }
    boot_disk {
      initialize_params {
        image_id = data.yandex_compute_image.ubuntu.image_id
      }
    }
    scheduling_policy {
    preemptible = true
    }
    network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }
    metadata = {
    serial-port-enable = var.metadata
    ssh-keys           = "ubuntu:${local.ssh}"
  }
}