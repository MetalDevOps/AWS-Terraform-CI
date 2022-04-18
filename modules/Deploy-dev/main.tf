provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "ninja-key" {
  key_name   = "ninja-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDODSFkYBS+BuU40+lPWG2G7ZenWQoRfH0aqcpkuNT+Hdp+zNcCngnRgEXm9c2GI+U2T86sHcDDSYvroxUsk92nrgHDoOY3Ip1mZXwoW6a4T1xs3FJxJbSZzkIeI6ElVDEarogy3I1hZboN9IA2VgfHmpbPhgxCUUpDehFvgF0T3A7xf0oYXbsu2BB7nq0GPs7d1ZZI3i5NbmQlyYRTZ/AYiXhHr2LULS1DNVk8TWmFJsvMY5aO+uVn3RVke5WhXyItSt3dS4JPdHuYm2UFQ21R7ZjHB9C5wuwHdYZp+TKDtBIg/Om/GhQUqJQIaG1qWhHXMYd9mjVuoBb3ffw7ZROG2od432o94lEdErZmUGpKO1FSydhF+l1xHN9Mdow19FrCmBWh+h2/KK5TbNmX2SDiuxB6CEWfgjuYvee4Uoo4nVB0T+NnVBbO5N3152LWX37RtXJLp92UVZaH/gdy7iwqx6KkzINl4y5qebem/lTgmAS9Vz4VMuwd6Qa6VerL8aRt0NLKGCOBWK4cQog4+SJawTj9btwCcTz8UmfsYYSvgJevQGT6UQuQE2jkavYyBtDyGjZ/nkWzrcF4B8fZ6bQ31wTPBooRqdnWq2L9ND8Igwcl2LG82iLCnCR2IPPxCORdnLOJcrWzjpXwZg5TBQlU6oPmtMEqdKLRObKZ/mosyw== egor@Egor-Nats"
}

resource "aws_security_group" "ninja-sg" {
  
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self = true
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

} 

resource "aws_instance" "ninja-worker" {
  ami           = "ami-0e472ba40eb589f49"
  instance_type = "t2.micro"
  key_name = "ninja-key"
  count = 1
  tags = {
    name = "ninja"
    type = "worker"
  }
  security_groups = ["${aws_security_group.ninja-sg.name}"]
}

resource "aws_instance" "ninja-master" {
  ami           = "ami-0e472ba40eb589f49"
  instance_type = "t2.micro"
  key_name = "ninja-key"
  count = 1
  tags = {
    name = "ninja"
    type = "master"
  }
  security_groups = ["${aws_security_group.ninja-sg.name}"]
}