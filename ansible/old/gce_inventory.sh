#!/bin/bash
cd ../terraform/stage
terraform state pull > terraform.tfstate # сохранить состояние из удаленного бакета в файл
terraform-inventory -list terraform.tfstate # получить из tfstate json для ansible
rm terraform.tfstate # удалить временный файл
