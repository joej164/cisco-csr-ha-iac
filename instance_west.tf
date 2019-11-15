# Create a new instance of the latest Ubuntu 14.04 on an
# t2.micro node with an AWS Tag naming it "HelloWorld"

data "aws_ami" "csr_west" {
  most_recent = true

  filter {
    name   = "name"
    values = ["cisco-CSR-.16.12.01a-BYOL-HVM-2-624f5bb1-7f8e-4f7c-ad2c-03ae1cd1c2d3-ami-0a35891127a1b85e1.4"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["679593333241"] # Cisco

  tags = {
    Project = "CSR HA",
    Owner   = "tomc@ignw.io",
    Team    = "DevOps"
    
  }
}

resource "aws_security_group" "ssh_in" {
  description = "Highly insecure SG permitting SSH"
  name        = "allow-ssh-sg_west"
  vpc_id      = "${module.vpc-west.vpc_id}"

  ingress {
    # TLS (change to whatever ports you need)
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"]
  }
}



resource "aws_instance" "csr_west" {
  ami           = "${data.aws_ami.csr_west.id}"
  instance_type = "t2.medium"

  tags = {
    Project = "CSR HA",
    Owner   = "tomc@ignw.io",
    Team    = "DevOps"
    
  }
}