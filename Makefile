backup:
	echo ""

validate:
	packer validate -var-file=./packer/secret.json ./packer/base.json

build:
	packer build -var-file=./packer/secret.json ./packer/base.json

test:
	echo ""

apply:
	echo ""
