resource "aws_instance" "web-node" {
  ami             = "ami-02eac2c0129f6376b"
  instance_type   = "t2.micro"

	tags = {
	Name = "Nginx-server"
	}
	security_groups = ["${aws_security_group.allow_ssh.name}"]
    	associate_public_ip_address = true

    # We're assuming there's a key with this name already
    	key_name = "NewSSH"

    # This is where we configure the instance with ansible-playbook
    	provisioner "local-exec" {
        command = "sleep 120; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u centos --private-key ./NewSSH.pem -i '${aws_instance.web-node.public_ip},' main.yml"
    }
}