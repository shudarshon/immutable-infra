provider "aws" {
  region  = "${var.aws_region}"
}

data "aws_availability_zones" "available" {}

resource "aws_key_pair" "SSHKeyPair" {
  key_name   = "${var.ssh_key_name}"
  public_key = "${file(var.public_key_path)}"
}

#ASG

#resource "random_id" "rand_asg" {
# byte_length = 8
#}

resource "aws_autoscaling_group" "WebAppASG" {
  name                      = "asg-${aws_launch_configuration.WebAppASGLaunchConfig.id}"
  max_size                  = "${var.asg_max}"
  min_size                  = "${var.asg_min}"
  health_check_grace_period = "${var.asg_grace}"
  health_check_type         = "${var.asg_hct}"
  desired_capacity          = "${var.asg_cap}"
  force_delete              = true
  load_balancers            = ["${aws_elb.WebAppELB.id}"]

  vpc_zone_identifier = ["${aws_subnet.wp_public2_subnet.id}",
    "${aws_subnet.wp_public1_subnet.id}",
  ]

  launch_configuration = "${aws_launch_configuration.WebAppASGLaunchConfig.name}"

  tag {
    key                 = "Name"
    value               = "wp_asg-instance"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}


#launch configuration

resource "aws_launch_configuration" "WebAppASGLaunchConfig" {
  name_prefix          = "wp_lc-"
  image_id             = "${var.ami_id}"
  instance_type        = "${var.asg_instance_type}"
  security_groups      = ["${aws_security_group.wp_private_sg.id}"]
  key_name             = "${aws_key_pair.SSHKeyPair.id}"

  lifecycle {
    create_before_destroy = true
  }
  depends_on = ["aws_elb.WebAppELB"]
}
