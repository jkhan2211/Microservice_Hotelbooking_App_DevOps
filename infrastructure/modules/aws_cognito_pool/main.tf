# terraform/modules/cognito/main.tf

# This Terraform configuration defines the following AWS Cognito resources:
# 1. Cognito User Pool (aws_cognito_user_pool): Creates a user pool with specified settings including account recovery, verification message template, auto-verified attributes, and password policy.
# 2. Cognito User Pool Domain (aws_cognito_user_pool_domain): Creates a domain for the user pool.
# 3. Cognito User Pool Client (aws_cognito_user_pool_client): Creates a user pool client with specified authentication flows and token validity settings.
resource "aws_cognito_user_pool" "user_pool" {
  name = "hotel-booking-users"

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }

  verification_message_template {
    default_email_option = "CONFIRM_WITH_LINK"
  }

  auto_verified_attributes = ["email"]

  schema {
    name                = "email"
    attribute_data_type = "String"
    required            = true
  }

  schema {
    name                = "given_name"
    attribute_data_type = "String"
    required            = false
  }

  schema {
    name                = "family_name"
    attribute_data_type = "String"
    required            = false
  }

  schema {
    name                = "address"
    attribute_data_type = "String"
    required            = false
  }

  password_policy {
    minimum_length                   = 8
    require_uppercase                = true
    require_lowercase                = true
    require_numbers                  = true
    require_symbols                  = true
    temporary_password_validity_days  = 7
  }

  admin_create_user_config {
    allow_admin_create_user_only = false  # Enables self-registration
  }

  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }
}

resource "aws_cognito_user_pool_domain" "user_pool_domain" {
  domain       = "hotel-app"
  user_pool_id = aws_cognito_user_pool.user_pool.id
}

resource "aws_cognito_user_pool_client" "user_pool_client" {
  name         = "hotelweb"
  user_pool_id = aws_cognito_user_pool.user_pool.id

  explicit_auth_flows = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_CUSTOM_AUTH"
  ]

  generate_secret = false

  callback_urls = ["http://localhost:8080/hotel/"]
  logout_urls   = ["http://localhost:8080/hotel/"]

  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["implicit", "code"]
  allowed_oauth_scopes                 = ["email", "openid", "profile"]

  access_token_validity  = 60
  id_token_validity      = 60
  refresh_token_validity = 7

  token_validity_units {
    access_token  = "minutes"
    id_token      = "minutes"
    refresh_token = "days"
  }
}
