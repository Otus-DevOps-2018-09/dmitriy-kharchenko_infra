data "template_file" "puma_service" {
  template = "${file("${path.module}/files/puma.service.tpl")}"

  vars {
    db_url = "${var.db_url}"
  }
}

resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "g1-small"
  zone         = "${var.zone}"
  tags         = ["reddit-app"]

  boot_disk {
    initialize_params {
      image = "${var.app_disk_image}"
    }
  }

  network_interface {
    network = "default"

    access_config = {
      nat_ip = "${google_compute_address.app_ip.address}"
    }
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }

  # connection {
  #   type        = "ssh"
  #   user        = "appuser"
  #   agent       = false
  #   private_key = "${file(var.private_key_path)}"
  # }

  # provisioner "remote-exec" {
  #   inline = [
  #     "echo '${data.template_file.puma_service.rendered}' > /tmp/puma.service",
  #   ]
  # }

  # provisioner "remote-exec" {
  #   script = "${path.module}/files/deploy.sh"
  # }
}

resource "google_compute_address" "app_ip" {
  name = "reddit-app-ip"
}
