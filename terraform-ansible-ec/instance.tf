# Logstash

resource "aws_instance" "Logstash" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = "${aws_subnet.Subnet-Public-TF-Ansible-ELK.id}"

  # the security group
  vpc_security_group_ids = ["${aws_security_group.TF-Ansible-ELK-SG.id}"]

  # the public SSH key
  key_name = "${var.KEY_NAME}"

  tags = {
    Name = "Logstash"
  }

  provisioner "remote-exec" {
     inline = [
       "sudo apt-get update",
       "sudo apt-get install python python-apt python-pip python-pycurl openjdk-8-jdk-headless -y",
     ]
  }

  provisioner "local-exec" {
     command = "ansible-playbook ansible/playbooks/logstash.yaml --ssh-common-args='-o StrictHostKeyChecking=no'  -u ${var.INSTANCE_USERNAME} --private-key ${var.LOCAL_KEY_NAME} -i terraform.py/terraform.py"
  }

  connection {
    user = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.LOCAL_KEY_NAME}")}"
    host     = aws_instance.Logstash.public_ip
  }

}

# Kibana

resource "aws_instance" "Kibana" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = "${aws_subnet.Subnet-Public-TF-Ansible-ELK.id}"

  # the security group
  vpc_security_group_ids = ["${aws_security_group.TF-Ansible-ELK-SG.id}"]

  # the public SSH key
  key_name = "${var.KEY_NAME}"

  tags = {
    Name = "Kibana"
  }

  provisioner "remote-exec" {
     inline = [
       "sudo apt-get install python python-apt -y",
     ]
  }

  connection {
    user = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.LOCAL_KEY_NAME}")}"
    host     = aws_instance.Kibana.public_ip
  }

}

# Elasticsearch

resource "aws_instance" "Elasticsearch" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = "${aws_subnet.Subnet-Public-TF-Ansible-ELK.id}"

  # the security group
  vpc_security_group_ids = ["${aws_security_group.TF-Ansible-ELK-SG.id}"]

  # the public SSH key
  key_name = "${var.KEY_NAME}"
  tags = {
    Name = "Elasticsearch"
  }
  provisioner "remote-exec" {
     inline = [
       "sudo apt-get update",
       "sudo apt-get install python python-apt python-pip python-pycurl -y",
     ]
  }

  provisioner "local-exec" {
     command = "ansible-playbook ansible/playbooks/elasticsearch.yaml --ssh-common-args='-o StrictHostKeyChecking=no'  -u ${var.INSTANCE_USERNAME} --private-key ${var.LOCAL_KEY_NAME} -i terraform.py/terraform.py"
  }

  connection {
    user = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.LOCAL_KEY_NAME}")}"
    host     = aws_instance.Elasticsearch.public_ip
  }

}

