locals {
  iam_groups = [
    "Administrators",
    "Developers",
    "Operations",
    "Finance",
    "Analysts"
  ]
}



# Use the IAM group module to create groups and assign users to them

module "developers" {
  source     = "./modules/iam_group"
  group_name = "Developers"
  user_list  = ["dev1", "dev2", "dev3", "dev4"]
}

module "operations" {
  source     = "./modules/iam_group"
  group_name = "Operations"
  user_list  = ["ops1", "ops2"]
}

module "finance" {
  source     = "./modules/iam_group"
  group_name = "Finance"
  user_list  = ["finance1"]
}


module "analysts" {
  source     = "./modules/iam_group"
  group_name = "Analysts"
  user_list  = ["analyst1", "analyst2", "analyst3"]
}
