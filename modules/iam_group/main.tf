# This modules creates an IAM group and assigns users to it
resource "aws_iam_group" "this" {
  name = var.group_name # Use the group name I passed into the module

}


# Attach users to the group
resource "aws_iam_user_group_membership" "this" {
  for_each = toset(var.user_list) # Repeats this block for every username in the list I give the module

  user   = each.value
  groups = [aws_iam_group.this.name] # Put this user into the group I just created above

}