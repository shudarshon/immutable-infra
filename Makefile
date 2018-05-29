backup:
	echo ""

validate:
	packer validate -var-file=./packer/secret.json ./packer/base.json

build:
	#packer build -machine-readable -var-file=./packer/secret.json ./packer/base.json | tee ./build.log
	golden_ami=`grep 'artifact,0,id' ./build.log | cut -d, -f6 | cut -d: -f2`
	sed -i -e "/ami_id/ s/= .*/= \"${golden_ami}\"/" ./terraform/terraform.tfvars
	#sed -i -e "/ami_id/ s/= .*/= \"`grep 'artifact,0,id' ./build.log | cut -d, -f6 | cut -d: -f2`\"/" ./terraform/terraform.tfvars
	ssh_username=`grep 'ssh_username' ./packer/base.json | cut -d, -f6 | cut -d: -f2 | head -n 1`
	sed -i -e "/ssh_user_name/ s/= .*/= ${ssh_username}/" ./terraform/terraform.tfvars

test:
	echo ""

apply:
	echo ""
