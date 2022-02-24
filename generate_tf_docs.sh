#!/bin/bash

# Generate README.md for child modules
for d in ./modules/*/; do 
  (cd "$d" && docker run --rm --volume "$(pwd):/terraform-docs" -u "$(id -u)" quay.io/terraform-docs/terraform-docs:0.16.0 markdown /terraform-docs > README.md); 
done

# Generate TERRAFORM_DOCS.md
docker run --rm \
--volume "$(pwd):/terraform-docs" \
-u "$(id -u)" quay.io/terraform-docs/terraform-docs:0.16.0 markdown /terraform-docs > TERRAFORM_DOCS.md
