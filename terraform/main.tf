provider "aws" {
  region  = "${var.aws_region}"
}

data "aws_availability_zones" "available" {}

resource "aws_key_pair" "SSHKeyPair" {
  key_name   = "${var.ssh_key_name}"
  public_key = "${file(var.public_key_path)}"
}

resource "aws_instance" "DevInstanceAWS" {
  count         = "${var.instance_count}"
  instance_type = "${var.instance_type}"
  ami           = "${var.ami_id}"
  iam_instance_profile   = "${aws_iam_instance_profile.s3_access_profile.id}"
  tags {
    Name = "wp_dev"
  }
  key_name        = "${aws_key_pair.SSHKeyPair.id}"
  subnet_id       = "${aws_subnet.wp_public1_subnet.id}"
  security_groups = [
        "${aws_security_group.wp_dev_sg.id}"
  ]

}
