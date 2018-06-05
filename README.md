# About
This repository contains some infrastructure as code for deploying app in a immutable infrastructure in AWS

# How to use

* Export your aws access key id and secret access key as following,
  `export AWS_ACCESS_KEY_ID="anaccesskey"
   export AWS_SECRET_ACCESS_KEY="asecretkey"`

* Make sure terraform, packer, maketool is installed in Jenkins.

* Set "region", "source_ami", "instance_type", "ssh_username" value in packer/base.json file.

* Also change configuration value in terraform/terraform.tfvars file.

* Make sure that you always put `*.tfvars` file in .gitignore.

* New git push will invoke jenkins to perform blue green deployment of immutable infrastructure.

* In my example, I created the jenkins pipeline named `Blue-Green`.

* Supported OS for instances are:

    * Debian/Ubuntu
    * RHEL/CentOS
    * Amazon Linux AMI
