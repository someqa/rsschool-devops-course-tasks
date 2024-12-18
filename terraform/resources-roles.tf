resource "aws_iam_openid_connect_provider" "github_actions_oidc_provider" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = [
    var.thumbnail
  ]
}

resource "aws_iam_role" "GithubActionsRole" {
  name               = "GithubActionsRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = "arn:aws:iam::${var.aws_account_id}:oidc-provider/token.actions.githubusercontent.com"
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          },
          StringLike = {
            "token.actions.githubusercontent.com:sub" = [
              "repo:${var.repository}:ref:*"
            ],
          }
        }
      }
    ]
  })
}



resource "aws_iam_role_policy_attachment" "attach_github_actions_policy" {
  for_each   = toset(var.gh_iam_policies)
  role       = aws_iam_role.GithubActionsRole.name
  policy_arn = each.value
}
