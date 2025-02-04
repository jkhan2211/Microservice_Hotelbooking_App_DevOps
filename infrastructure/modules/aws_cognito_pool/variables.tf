# terraform/modules/cognito/variables.tf

# This Terraform configuration defines the following input variables of the cognito module:
# 1. aws_region: The AWS region to deploy resources.
# 2. cognito_user_pool_name: The name of the Cognito User Pool.
# 3. cognito_app_client_name: The name of the Cognito App Client.
# 4. cognito_user_pool_domain: The domain name for the Cognito user pool.

variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default = "us-east-1"
}

variable "cognito_user_pool_name" {
  description = "The name of the Cognito User Pool"
  type        = string
  default = "hotel-booking-users"
}

variable "cognito_app_client_name" {
  description = "The name of the Cognito App Client"
  type        = string
  default = "web"
}


variable "cognito_user_pool_domain" {
  description = "The domain name for the Cognito user pool"
  type        = string
  default = "hotelbookingweb"
}