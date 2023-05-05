Terraform commands to run in order to have two vms, one for jenkins and the other for nexus : 

terraform init -upgrade
terraform plan -out main.tfplan
terraform apply main.tfplan

Once you have the public IPs of the vms, you can ssh using these commands :

terraform output -raw tls_private_key > id_rsa
chmod 600 id_rsa
ssh -i id_rsa azureuser@<public_ip>

To destroy everything :

terraform plan -destroy -out main.destroy.tfplan
terraform apply main.destroy.tfplan
