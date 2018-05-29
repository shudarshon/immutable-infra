resource "random_id" "GoldenAmiID" {
  byte_length = 8
}

resource "aws_ami_from_instance" "GoldenAMI" {
  name               = "wp_ami-${random_id.GoldenAmiID.b64}"
  source_instance_id = "${aws_instance.DevInstanceAWS.id}"
  depends_on = ["aws_instance.DevInstanceAWS"]
}
