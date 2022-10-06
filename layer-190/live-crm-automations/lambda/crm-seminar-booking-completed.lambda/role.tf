# Give read and write permissions to Dynamo table live-groups-backoffice-v1
resource "aws_iam_role_policy" "lambda-live-groups-account-verifier-dynamodb-live-groups-backoffice-v1-readonly" {
  name   = "dynamodb-table-live-groups-backoffice-v1-readonly"
  role   = module.lambda-live-groups-account-verifier.role.name
  policy = data.aws_iam_policy_document.dynamodb-table-live-groups-backoffice-v1-readonly.json
}

resource "aws_iam_role_policy" "lambda-live-groups-account-verifier-dynamodb-live-groups-backoffice-v1-writeonly" {
  name   = "dynamodb-table-live-groups-backoffice-v1-writeonly"
  role   = module.lambda-live-groups-account-verifier.role.name
  policy = data.aws_iam_policy_document.dynamodb-table-live-groups-backoffice-v1-writeonly.json
}
