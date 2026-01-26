
# Bind each JSON file to a real IAM policy resource
# This will work once the JSON files are populated with least-privilege policies
# Validate JSON syntax using "jg . policies/filename.json" command
# Use "terraform fmt -recursive" to format JSON files properly



# EC2 Start/Stop & Describe [no create or terminate]
# S3 Read/Write only in app bucket [no delete to prevent accidental data loss]
# CloudWatch Logs Read-only
# Developers can only access their application bucket
resource "aws_iam_policy" "developers_policy" {
  name        = "DevelopersPolicy"
  description = "Least-privilege Policy for developers"
  policy      = file("${path.module}/policies/developers.json")

}

# EC2 full control except IAM roles
# S3 full bucket access but scoped to only project buckets -> best practice scoped least-privilege [wide action + narrow resource]
# RDS instance management except IAM authentication
# SSM full control
# CloudWatch full control
# No access to billing, IAM, or organization resources -> prevents privilege escalation...
# ...so user wont be able to modify their own permissions
resource "aws_iam_policy" "operations_policy" {
  name        = "OperationsPolicy"
  description = "Least-privilege Policy for operations team"
  policy      = file("${path.module}/policies/operations.json")

}


# Billing, Cost explorer, Budgets full access
# Read-only for anything else
resource "aws_iam_policy" "finance_policy" {
  name        = "FinancePolicy"
  description = "Least-privilege Policy for finance team"
  policy      = file("${path.module}/policies/finance.json")

}


# S3 read-only access to specific data buckets
# RDS read-only access to reporting DBs
# AM cannot grant SQL-level read-only access to RDS.
# To give Analysts actual read-only access to database tables, the correct method is to create a database user with SELECT privileges inside the MySQL/Postgres engine.
# For the purpose of this IAM project, metadata read-only access via IAM is implemented.”
resource "aws_iam_policy" "analysts_policy" {
  name        = "AnalystsPolicy"
  description = "Least-privilege Policy for analysts"
  policy      = file("${path.module}/policies/analysts.json")

}


# Attach policies to groups
resource "aws_iam_policy_attachment" "developers_attach" {
  name       = "developers-attachment"
  groups     = [module.developers.group_name]
  policy_arn = aws_iam_policy.developers_policy.arn

}

resource "aws_iam_policy_attachment" "operations_attach" {
  name       = "operations-attachment"
  groups     = [module.operations.group_name]
  policy_arn = aws_iam_policy.operations_policy.arn

}

resource "aws_iam_policy_attachment" "finance_attach" {
  name       = "finance-attachment"
  groups     = [module.finance.group_name]
  policy_arn = aws_iam_policy.finance_policy.arn

}

resource "aws_iam_policy_attachment" "analysts_attach" {
  name       = "analysts-attachment"
  groups     = [module.analysts.group_name]
  policy_arn = aws_iam_policy.analysts_policy.arn

}