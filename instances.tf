# Create a new instance of the latest Ubuntu 14.04 on an
# t2.micro node with an AWS Tag naming it "HelloWorld"

data "aws_ami" "csr" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ami-0ea109acd52c4b94d"]
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
  name        = "allow-ssh-sg"
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



resource "aws_instance" "csr" {
  ami           = "${data.aws_ami.csr.id}"
  instance_type = "t2.micro"

  tags = {
    Project = "CSR HA",
    Owner   = "tomc@ignw.io",
    Team    = "DevOps"
    
  }
}