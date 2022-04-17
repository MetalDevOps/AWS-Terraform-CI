# AWS-Terraform-CI


### Clone esse repositorio

```
git clone https://github.com/whoamikyo/AWS-Terraform-CI && cd AWS-Terraform-CI
```

### Inicie o Terraform

```
terraform init
```

### Aplique


```
terraform apply --auto-approve
```


# Ansible

#### Com esse comando será feito o deploy de um github runner em todas as maquinas criadas com o terraform que possuem a tag "worker"

```
ansible-playbook -i aws_ec2.yaml --limit "tag_name_ninja" -u ubuntu -e "action=add" setup-runner.yml
```

#### Para remover o runner é só rodar esse comando

```
ansible-playbook -i aws_ec2.yaml --limit "tag_name_ninja" -u ubuntu -e "action=remove" setup-runner.yml
```