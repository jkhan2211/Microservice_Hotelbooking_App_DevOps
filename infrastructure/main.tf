module "cognito" {
  source                   = "./modules/aws_cognito_pool"
  aws_region               = var.aws_region
  cognito_user_pool_name   = var.cognito_user_pool_name
  cognito_app_client_name  = var.cognito_app_client_name
  cognito_user_pool_domain = var.cognito_user_pool_domain
}
