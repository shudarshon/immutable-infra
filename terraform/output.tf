output "db-endpoint" {
  value = "${aws_db_instance.RDSWebApp.endpoint}"
}

output "elb-endpoint" {
  value = "${aws_elb.WebAppELB.dns_name}" 
}
