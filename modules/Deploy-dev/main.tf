provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "ninja-key" {
  key_name   = "ninja-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDODSFkYBS+BuU40+lPWG2G7ZenWQoRfH0aqcpkuNT+Hdp+zNcCngnRgEXm9c2GI+U2T86sHcDDSYvroxUsk92nrgHDoOY3Ip1mZXwoW6a4T1xs3FJxJbSZzkIeI6ElVDEarogy3I1hZboN9IA2VgfHmpbPhgxCUUpDehFvgF0T3A7xf0oYXbsu2BB7nq0GPs7d1ZZI3i5NbmQlyYRTZ/AYiXhHr2LULS1DNVk8TWmFJsvMY5aO+uVn3RVke5WhXyItSt3dS4JPdHuYm2UFQ21R7ZjHB9C5wuwHdYZp+TKDtBIg/Om/GhQUqJQIaG1qWhHXMYd9mjVuoBb3ffw7ZROG2od432o94lEdErZmUGpKO1FSydhF+l1xHN9Mdow19FrCmBWh+h2/KK5TbNmX2SDiuxB6CEWfgjuYvee4Uoo4nVB0T+NnVBbO5N3152LWX37RtXJLp92UVZaH/gdy7iwqx6KkzINl4y5qebem/lTgmAS9Vz4VMuwd6Qa6VerL8aRt0NLKGCOBWK4cQog4+SJawTj9btwCcTz8UmfsYYSvgJevQGT6UQuQE2jkavYyBtDyGjZ/nkWzrcF4B8fZ6bQ31wTPBooRqdnWq2L9ND8Igwcl2LG82iLCnCR2IPPxCORdnLOJcrWzjpXwZg5TBQlU6oPmtMEqdKLRObKZ/mosyw== egor@Egor-Nats"
}

resource "aws_security_group" "ninja-sg" {
  name        = "ninja-sg"
  description = "Security group apenas para liberar acesso as portas 80/443/22"
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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
  ami           = "ami-03ededff12e34e59e"
  instance_type = "t2.micro"
  key_name = "ninja-key"
  count = 1
  tags = {
    name = "ninja"
    type = "master"
  }
  
  iam_instance_profile = aws_iam_instance_profile.ec2-role_profile.name

  security_groups = ["${aws_security_group.ninja-sg.name}"]

  user_data = data.template_file.user_data.rendered

}

data "template_file" "user_data" {
  template = file("${path.module}/user-data.sh")

}

resource "aws_iam_instance_profile" "ec2-role_profile" {
  name =  "codedeploy-ec2-role-profile"
  role =  aws_iam_role.codedeploy-ec2-role.name
}

resource "aws_iam_role" "codedeploy-ec2-role" {
  name = "codedeploy-ec2-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com",
        "Service": "codedeploy.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    Name          = "codedeploy-ec2-role"
  }
}

resource "aws_iam_role_policy_attachment" "ec2-role-attach-cd" {
  role        = aws_iam_role.codedeploy-ec2-role.name
  policy_arn  = "arn:aws:iam::aws:policy/AWSCodeDeployFullAccess"
}

resource "aws_iam_role_policy_attachment" "ec2-role-attach-s3" {
  role        = aws_iam_role.codedeploy-ec2-role.name
  policy_arn  = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "ec2-role-attach-ec2" {
  role        = aws_iam_role.codedeploy-ec2-role.name
  policy_arn  = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_role" "codedeploy-role" {
  name = "codedeploy-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "codedeploy.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    Name          = "codedeploy-role"
  }
}

resource "aws_iam_role_policy_attachment" "cd-role-attach" {
  role        = aws_iam_role.codedeploy-role.name
  policy_arn  = "arn:aws:iam::aws:policy/AWSCodeDeployFullAccess"
}