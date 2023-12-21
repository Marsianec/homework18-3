resource "yandex_compute_instance" "web" {
    depends_on = [yandex_compute_instance.db]
    count = var.name_count
    name = "web-${count.index + 1}"
    resources {
      cores = 2
      memory = 1
      core_fraction = 5
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
