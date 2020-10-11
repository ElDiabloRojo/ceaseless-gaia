## Requirements

| Name | Version |
|------|---------|
| aws | ~> 2.60.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.60.0 |
| aws.acm | ~> 2.60.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bucket\_name | The Fully Qualified domain name should be the bucket name | `string` | `""` | no |
| certificate\_arn | n/a | `string` | n/a | yes |
| domain | simple website where route53 hosted zone and bucket name are same. Naked domain | `string` | `""` | no |
| error\_document | Error page to be used for website. Defaults to error.html | `string` | `"error.html"` | no |
| error\_file\_source | n/a | `string` | `"./src/error.html"` | no |
| index\_document | Index page to be used for website. Defaults to index.html | `string` | `"index.html"` | no |
| index\_file\_source | n/a | `string` | `"./src/index.html"` | no |
| route53\_hosted\_zone\_id | n/a | `string` | n/a | yes |
| route53\_zone\_id | [TODO: consolidate zone related vars into one, they are the same.] | `string` | n/a | yes |
| s3\_force\_destroy | Destroy the s3 bucket inspite of contents in it. | `string` | `"false"` | no |
| secret\_user\_agent | secret to authenticate CF requests to s3 | `string` | `"SECRET-STRING"` | no |

## Outputs

| Name | Description |
|------|-------------|
| cloudfront\_domain | n/a |
| cloudfront\_hosted\_zone | n/a |
| route53\_app\_fqdn | n/a |
| s3\_hosted\_zone\_id | n/a |

