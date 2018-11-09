#!/bin/bash

if [[ -z "${PROJECT_ROOT}" ]]; then
  >&2 echo "environment variable PROJECT_ROOT not set"
  exit 1
fi

cd $PROJECT_ROOT/terraform/stage/
terraform state pull > terraform.tfstate # сохранить состояние из удаленного бакета в файл
terraform-inventory -list terraform.tfstate # получить из tfstate json для ansible
rm terraform.tfstate # удалить временный файл
