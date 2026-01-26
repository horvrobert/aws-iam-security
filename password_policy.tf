# Password policy will enforce complexity, rotation, and reuse prevention.
# Compliant with best practices for IAM user passwords.
# NIST modern password guidelines are considered.
# Security without unnecessary rotation.

resource "aws_iam_account_password_policy" "strict" {
  minimum_password_length        = 12
  require_uppercase_characters   = true
  require_lowercase_characters   = true
  require_numbers                = true
  require_symbols                = true
  allow_users_to_change_password = true
  password_reuse_prevention      = 5
  max_password_age               = 90
}