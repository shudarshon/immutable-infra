backup:
	echo ""

validate:
	/usr/local/bin/packer validate -var-file=/var/lib/jenkins/workspace/Blue-Green/packer/secret.json /var/lib/jenkins/workspace/Blue-Green/packer/base.json
	cd /var/lib/jenkins/workspace/Blue-Green/terraform && /usr/local/bin/terraform validate

build:
	/usr/local/bin/packer build -machine-readable -var-file=./packer/secret.json ./packer/base.json | /usr/bin/tee ./build.log

	#change region, ami_id and ssh username from packer configuration to terraform tfvars

	#region=`grep 'region' ./packer/base.json | cut -d: -f2 | head -n 1 | tr -d ','`
	#golden_ami=`grep 'artifact,0,id' ./build.log | cut -d, -f6 | cut -d: -f2`
	/bin/sed -i -e "/region/ s/= .*/= `/bin/grep 'region' /var/lib/jenkins/workspace/Blue-Green/packer/base.json | /usr/bin/cut -d: -f2 | /usr/bin/head -n 1 | /usr/bin/tr -d ','`/" /var/lib/jenkins/workspace/Blue-Green/terraform/terraform.tfvars
	/bin/sed -i -e "/ami_id/ s/= .*/= \"`/bin/grep 'artifact,0,id' /var/lib/jenkins/workspace/Blue-Green/build.log | /usr/bin/cut -d: -f2`\"/" /var/lib/jenkins/workspace/Blue-Green/terraform/terraform.tfvars
	#ssh_username=`grep 'ssh_username' ./packer/base.json | cut -d: -f2 | head -n 1 | tr -d ' '`
	/bin/sed -i -e "/ssh_user_name/ s/= .*/= `/bin/grep 'ssh_username' /var/lib/jenkins/workspace/Blue-Green/packer/base.json | /usr/bin/cut -d: -f2 | /usr/bin/head -n 1 | /usr/bin/tr -d ' '`/" /var/lib/jenkins/workspace/Blue-Green/terraform/terraform.tfvars

initialize:
	cd /var/lib/jenkins/workspace/Blue-Green/terraform && /usr/local/bin/terraform init

apply:
	cd /var/lib/jenkins/workspace/Blue-Green/terraform && /usr/local/bin/terraform apply -auto-approve

destroy:
	cd /var/lib/jenkins/workspace/Blue-Green/terraform && /usr/local/bin/terraform destroy -auto-approve
