# About
This repository contains some infrastructure as code for deploying app in a immutable infrastructure in AWS

# How to use

* Export your aws access key id and secret access key as following,
  `export AWS_ACCESS_KEY_ID="anaccesskey"
   export AWS_SECRET_ACCESS_KEY="asecretkey"`

* Make sure terraform, packer, make tool is installed in Jenkins.

* Set "region", "source_ami", "instance_type", "ssh_username" value in packer/base.json file.

* Also change configuration value in terraform/terraform.tfvars file.

* Make sure that you always put `*.tfvars` file in .gitignore.

* New git push will invoke jenkins to perform blue green deployment of immutable infrastructure.

* Supported OS for instances are:

    * Debian/Ubuntu (packer AMI needed to be changed)
    * RHEL/CentOS
    * Amazon Linux AMI
