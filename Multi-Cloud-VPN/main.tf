module "aws_vpc" {
  source = "./aws/vpc"

}


resource "null_resource" "tomcat" {
  connection {
    type        = "ssh"
    user        = var.user
    private_key = file(var.private-key)
    host        = google_compute_address.tomcat.address
  }
  provisioner "file" {
    source      = "tomcat.sh"
    destination = "/tmp/tomcat.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/tomcat.sh",
      "sh /tmp/tomcat.sh",
    ]
  }

  depends_on = [
    google_compute_instance.tomcat
  ]
}