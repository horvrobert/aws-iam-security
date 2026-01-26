# Exposes the IAM group name created inside this module to the parent/root module.
# This makes the module reusable: other Terraform resources can reference
# `module.<module_name>.group_name` without hardcoding the group name.
# Can be useful for debugging
output "group_name" {
  value = aws_iam_group.this.name

}