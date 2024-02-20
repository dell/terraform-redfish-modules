docs:
	# install via
	# go install github.com/terraform-docs/terraform-docs@v0.17.0
	terraform-docs markdown table --output-file README.md --output-mode inject modules/redfish_idrac_secure_erase/
	terraform-docs markdown table --output-file README.md --output-mode inject examples/secure_erase/
