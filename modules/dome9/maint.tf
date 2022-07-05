resource "dome9_cloudaccount_aws" "this" {
  name = var.account_name

  credentials {
    arn    = aws_iam_role.dome9.arn
    secret = var.external_id
    type   = "RoleBased"
  }

  net_sec {
    regions {
      new_group_behavior = "ReadOnly"
      region             = "us_east_1"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "us_west_1"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "eu_west_1"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "ap_southeast_1"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "ap_northeast_1"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "us_west_2"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "sa_east_1"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "ap_southeast_2"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "eu_central_1"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "ap_northeast_2"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "ap_south_1"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "us_east_2"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "ca_central_1"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "eu_west_2"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "eu_west_3"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "eu_north_1"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "ap_east_1"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "me_south_1"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "af_south_1"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "eu_south_1"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "ap_northeast_3"
    }
  }
}

#Create the role and setup the trust policy
resource "aws_iam_role" "dome9" {
  name               = "BCGOV_CloudGuardConnect"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${var.dome9_aws_account_id}:root"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": "${var.external_id}"
        }
      }
    }
  ]
}
EOF
}

#Create the readonly policy
resource "aws_iam_policy" "readonly-policy" {
  name        = "BCGOV_CloudGuardReadOnly"
  description = ""
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "CloudGuardReadOnly",
            "Action": [
                "account:GetAlternateContact",
                "apigateway:GET",
                "athena:GetQueryExecution",
                "athena:GetWorkGroup",
                "backup:ListBackupVaults",
                "backup:ListTags",
                "cognito-identity:DescribeIdentityPool",
                "cognito-idp:DescribeUserPool",
                "cognito-idp:DescribeRiskConfiguration",
                "macie2:DescribeBuckets",
                "macie2:GetMacieSession",
                "dynamodb:ListTagsOfResource",
                "ec2:SearchTransitGatewayRoutes",
                "elasticfilesystem:Describe*",
                "elasticache:ListTagsForResource",
                "es:ListTags",
                "eks:DescribeNodegroup",
                "eks:ListNodegroups",
                "glue:GetConnections",
                "glue:GetSecurityConfigurations",
                "inspector2:ListFindings",
                "inspector2:BatchGetAccountStatus",
                "kafka:ListClusters",
                "kinesis:List*",
                "kinesis:Describe*",
                "kinesisvideo:Describe*",
                "kinesisvideo:List*",
                "logs:Get*",
                "logs:FilterLogEvents",
                "logs:ListLogDeliveries",
                "mq:DescribeBroker",
                "mq:ListBrokers",
                "network-firewall:DescribeFirewall",
                "network-firewall:DescribeLoggingConfiguration",
                "network-firewall:ListFirewalls",
                "network-firewall:DescribeRuleGroup",
                "network-firewall:DescribeFirewallPolicy",
                "personalize:DescribeDatasetGroup",
                "personalize:ListDatasetGroups",
                "s3:List*",
                "secretsmanager:DescribeSecret",
                "sns:ListSubscriptions",
                "sns:ListTagsForResource",
                "sns:GetPlatformApplicationAttributes",
                "sns:ListPlatformApplications",
                "states:DescribeStateMachine",
                "transcribe:Get*",
                "transcribe:List*",
                "translate:GetTerminology",
                "waf-regional:ListResourcesForWebACL",
                "wafv2:ListWebACLs",
                "wafv2:ListResourcesForWebACL",
                "eks:ListFargateProfiles",
                "eks:DescribeFargateProfile"
            ],
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Sid": "ElasticbeanstalkConfigurationSettingsPermission",
            "Action": [
                "s3:GetObject"
            ],
            "Effect": "Allow",
            "Resource": "arn:aws:s3:::elasticbeanstalk-env-resources-??*?/*"
        }
    ]
}
EOF
}

#Attach policies to the cross-account role
resource "aws_iam_policy_attachment" "attach-d9-read-policy" {
  name       = "attach-readonly"
  roles      = [aws_iam_role.dome9.name]
  policy_arn = aws_iam_policy.readonly-policy.arn
}

resource "aws_iam_role_policy_attachment" "attach-security-audit" {
  role       = aws_iam_role.dome9.name
  policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
}
