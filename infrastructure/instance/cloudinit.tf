

data "template_cloudinit_config" "cloudinit_user_data" {

  part {
    content_type = "text/cloud-config"
    content      = data.template_file.write_httpd_installation.rendered
    merge_type   = "dict(recurse_array,no_replace)+list(append)"
  }
}

data "template_file" "write_httpd_installation" {
  template = file("data/write_httpd_installation_script.yaml")

  vars = {
    install_httpd = base64encode(data.template_file.install_httpd_sh.rendered)
  }
}

data "template_file" "install_httpd_sh" {
  template = file("${path.module}/data/scripts/install_httpd.sh")

}

