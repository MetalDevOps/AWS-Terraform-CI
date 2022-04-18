module "deploy-dev" {
  source = "./modules/Deploy-dev"
}

module "action-dev" {
  source = "./modules/Action-role-dev"
}

module "action-prod" {
  source = "./modules/Action-role-prod"
}