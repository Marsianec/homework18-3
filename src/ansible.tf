resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/ansible.tftpl", 
  { webservers =  yandex_compute_instance.web, database = yandex_compute_instance.db, storage = yandex_compute_instance.st }  )
  filename = "${abspath(path.module)}/hosts.cfg"
}
