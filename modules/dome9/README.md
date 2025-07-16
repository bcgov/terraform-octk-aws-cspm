<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.57.0 |
| <a name="requirement_dome9"></a> [dome9](#requirement\_dome9) | 1.29.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.57.0 |
| <a name="provider_dome9"></a> [dome9](#provider\_dome9) | 1.29.0 |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.readonly-policy](https://registry.terraform.io/providers/hashicorp/aws/5.57.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy_attachment.attach-d9-read-policy](https://registry.terraform.io/providers/hashicorp/aws/5.57.0/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_role.dome9](https://registry.terraform.io/providers/hashicorp/aws/5.57.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.attach-security-audit](https://registry.terraform.io/providers/hashicorp/aws/5.57.0/docs/resources/iam_role_policy_attachment) | resource |
| [dome9_cloudaccount_aws.this](https://registry.terraform.io/providers/dome9/dome9/1.29.0/docs/resources/cloudaccount_aws) | resource |
| [time_sleep.wait_for_role](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_name"></a> [account\_name](#input\_account\_name) | n/a | `string` | n/a | yes |
| <a name="input_dome9_aws_account_id"></a> [dome9\_aws\_account\_id](#input\_dome9\_aws\_account\_id) | n/a | `string` | n/a | yes |
| <a name="input_external_id"></a> [external\_id](#input\_external\_id) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->