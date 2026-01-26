locals {
  iam_users = [
    "dev1",
    "dev2",
    "dev3",
    "dev4",
    "ops1",
    "ops2",
    "finance1",
    "analyst1",
    "analyst2",
    "analyst3"
  ]
}


# This block creates IAM users based on the list defined above
resource "aws_iam_user" "users" {
  for_each = toset(local.iam_users)

  name = each.value

}