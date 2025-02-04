# terraform/modules/cognito/outputs.tf

# This Terraform configuration defines the following outputs of the cognito module:
# 1. user_pool_id: The ID of the created Cognito User Pool.
# 2. user_pool_client_id: The ID of the created Cognito User Pool Client.

output "user_pool_id" {
  value = aws_cognito_user_pool.user_pool.id
}

output "user_pool_client_id" {
  value = aws_cognito_user_pool_client.user_pool_client.id
}