
// role for codepipeline

resource "aws_iam_role" "codepipeline_role" {
  name = "pipeline-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

// policy for codepipeline

resource "aws_iam_role_policy" "codepipeline_policy" {
  name = "pipeline_policy"
  role = aws_iam_role.codepipeline_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect":"Allow",
      "Action": [
        "s3:GetObject",
        "s3:GetObjectVersion",
        "s3:GetBucketVersioning",
        "s3:PutObjectAcl",
        "s3:PutObject"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "codebuild:BatchGetBuilds",
        "codebuild:StartBuild"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}


// role for codebuild

resource "aws_iam_role" "codebuild_role" {
  name = "codebuild_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

// policy for codebuild

resource "aws_iam_role_policy" "codebuild_policy" {
  name = "build_policy"
  role = aws_iam_role.codebuild_role.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Resource": [
        "*"
      ],
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:CreateNetworkInterface",
        "ec2:DescribeDhcpOptions",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DeleteNetworkInterface",
        "ec2:DescribeSubnets",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeVpcs",
        "ec2:Describe*"
      ],
      "Resource": "*"
    },
   {
      "Effect": "Allow",
      "Action": [
        "ec2:CreateNetworkInterfacePermission"
      ],
      "Resource": [
        "arn:aws:ec2:eu-west-2:939389761016:network-interface/*"
      ],
      "Condition": {
        "StringEquals": {
          "ec2:AuthorizedService": "codebuild.amazonaws.com"
        }
      }
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:GetObjectVersion",
        "s3:GetBucketVersioning",
        "s3:PutObjectAcl",
        "s3:PutObject"
      ],
      "Resource":"*"
    },
{
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "elasticloadbalancing:ModifyListener",
                "ec2:AuthorizeSecurityGroupIngress",
                "ec2:ReplaceRouteTableAssociation",
                "rds:*",
                "ec2:CreateKeyPair",
                "ec2:AttachInternetGateway",
                "codebuild:*",
                "ec2:DeleteRouteTable",
                "ec2:UpdateSecurityGroupRuleDescriptionsIngress",
                "route53:Get*",
                "ec2:CreateRoute",
                "ec2:CreateInternetGateway",
                "ec2:RevokeSecurityGroupEgress",
                "elasticloadbalancing:AddListenerCertificates",
                "ec2:DeleteInternetGateway",
                "s3:DeleteObject",
                "ec2:ImportKeyPair",
                "ec2:CreateTags",
                "elasticloadbalancing:CreateTargetGroup",
                "ec2:RunInstances",
                "ec2:DisassociateRouteTable",
                "ec2:ReplaceNetworkAclAssociation",
                "ec2:RevokeSecurityGroupIngress",
                "s3:PutObject",
                "elasticloadbalancing:AddTags",
                "ec2:CreateSubnet",
                "elasticloadbalancing:ModifyLoadBalancerAttributes",
                "ec2:DeleteNetworkAclEntry",
                "ec2:CreateVpc",
                "s3:ListBucket",
                "elasticloadbalancing:RemoveListenerCertificates",
                "ec2:ModifySubnetAttribute",
                "elasticloadbalancing:DescribeListenerCertificates",
                "ssm:GetParametersByPath",
                "s3:DeleteBucket",
                "ec2:DeleteNetworkAcl",
                "elasticloadbalancing:CreateLoadBalancer",
                "elasticloadbalancing:SetSubnets",
                "ec2:DisassociateSubnetCidrBlock",
                "elasticloadbalancing:DeleteTargetGroup",
                "ec2:Describe*",
                "elasticloadbalancing:DescribeTargetGroups",
                "acm:*",
                "elasticloadbalancing:DeleteListener",
                "ec2:DeleteSubnet",
                "elasticloadbalancing:RegisterTargets",
                "ec2:AcceptVpcPeeringConnection",
                "ec2:DeleteVpcPeeringConnection",
                "s3:CreateBucket",
                "ssm:GetParameter",
                "ec2:ReplaceRoute",
                "ec2:RejectVpcPeeringConnection",
                "ec2:AssociateRouteTable",
                "elasticloadbalancing:DeleteLoadBalancer",
                "elasticloadbalancing:DescribeLoadBalancers",
                "ec2:ReplaceNetworkAclEntry",
                "elasticloadbalancing:CreateRule",
                "ec2:ModifyVpcPeeringConnectionOptions",
                "route53:List*",
                "elasticloadbalancing:ModifyTargetGroupAttributes",
                "ec2:CreateVpcPeeringConnection",
                "ec2:Get*",
                "ec2:UpdateSecurityGroupRuleDescriptionsEgress",
                "ec2:CreateRouteTable",
                "route53:ChangeResourceRecordSets",
                "elasticloadbalancing:DeregisterTargets",
                "ssm:GetParameters",
                "ec2:DetachInternetGateway",
                "elasticloadbalancing:DescribeLoadBalancerAttributes",
                "iam:*",
                "s3:GetObject",
                "elasticloadbalancing:DescribeTargetGroupAttributes",
                "elasticloadbalancing:ModifyRule",
                "elasticloadbalancing:DescribeRules",
                "ec2:DeleteVpc",
                "ec2:DeleteKeyPair",
                "ec2:DeleteTags",
                "elasticloadbalancing:RemoveTags",
                "elasticloadbalancing:CreateListener",
                "elasticloadbalancing:DescribeListeners",
                "ec2:CreateSecurityGroup",
                "ec2:CreateNetworkAcl",
                "ec2:ModifyVpcAttribute",
                "elasticloadbalancing:DeleteRule",
                "elasticloadbalancing:DescribeSSLPolicies",
                "ec2:AuthorizeSecurityGroupEgress",
                "ec2:TerminateInstances",
                "elasticloadbalancing:DescribeTags",
                "ec2:DeleteRoute",
                "ssm:Describe*",
                "ec2:DeleteSecurityGroup",
                "elasticloadbalancing:DescribeTargetHealth",
                "elasticloadbalancing:SetSecurityGroups",
                "codepipeline:*",
                "ec2:CreateNetworkAclEntry",
                "s3:GetBucketLocation",
                "elasticloadbalancing:ModifyTargetGroup",
                "kms:ListAliases"
            ],
            "Resource": "*"
        }
  ]
}
POLICY
}
