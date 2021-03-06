data aws_subnet app_subnet {
  filter {
    name   = "tag:Name"
    values = [var.subnet_name]
  }
}

data aws_ami linux {
  most_recent = true
  name_regex  = var.vm_os_image_spec.name_regex

  filter {
    name   = "name"
    values = [var.vm_os_image_spec.name_filter]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  owners = [var.vm_os_image_spec.owner]
}

data aws_ami windows {
  most_recent = true
  name_regex  = var.vm_os_image_spec.name_regex

  filter {
    name   = "name"
    values = [var.vm_os_image_spec.name_filter]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  
  owners = [var.vm_os_image_spec.owner]
}


resource aws_instance vm {
  ami                         = var.vm_os_windows ? data.aws_ami.windows.id : (var.vm_os_linux ? data.aws_ami.linux.id : "ERROR: invalid OS")
  instance_type               = var.vm_perf_class
  subnet_id                   = data.aws_subnet.app_subnet.id
  vpc_security_group_ids      = [] #TODO
  associate_public_ip_address = false

  tags = merge({
    Name   = "${var.vm_name}-vm"
    Region = var.main_region
    Env    = lower(terraform.workspace)
    OSType = var.vm_os_windows ? "windows" : "linux"
    },
  var.tags)
}
