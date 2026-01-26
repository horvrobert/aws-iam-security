# MFA enforcement will be implemented using a deny policy:
# If the user is not authenticated with MFA, all actions are denied.
# AWS requires users to configure MFA manually - Terraform cannot automate device enrollment.

resource "aws_iam_policy" "mfa_enforce" {
  name        = "MFAEnforcePolicy"
  description = "Deny all actions if MFA is not used"
  policy      = file("${path.module}/policies/mfa_enforce.json")
}

resource "aws_iam_policy_attachment" "mfa_enforce_attach" {
  name       = "mfa-enforce-attachment"
  policy_arn = aws_iam_policy.mfa_enforce.arn
  users      = [for user in aws_iam_user.users : user.name]
}