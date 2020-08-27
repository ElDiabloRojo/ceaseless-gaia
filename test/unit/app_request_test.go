package test

import (
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/aws"
	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAppUnit(t *testing.T) {
	awsRegion := aws.GetRandomStableRegion(t, nil, nil)
	bucket_name := "test.phytology.co.uk"
	s3_force_destroy := true
	terraformOptions := &terraform.Options{
		TerraformDir: "../../modules/website",
		Vars: map[string]interface{}{
			"bucket_name":            bucket_name,
			"route53_zone_id":        "Z03696073LWK1WSI1Q63",
			"route53_hosted_zone_id": "Z03696073LWK1WSI1Q63",
			"s3_force_destroy":       s3_force_destroy,
		},
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": awsRegion,
		},
	}
	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)
	validate(t, terraformOptions)
}

func validate(t *testing.T, terraformOptions *terraform.Options) {
	url := terraform.Output(t, terraformOptions, "route53_app_fqdn")

	expectedStatus := 200
	expectedBody := "Welcome to the static site provisioned by Terraform !!!"
	maxRetries := 10
	timeBetweenRetries := 3 * time.Second
	http_helper.HttpGetWithRetry(t, url, nil, expectedStatus, expectedBody, maxRetries, timeBetweenRetries)
}
