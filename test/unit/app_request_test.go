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
	bucketName := "test.phytology.co.uk"
	s3ForceDestroy := true
	terraformOptions := &terraform.Options{
		TerraformDir: "../../modules/website",
		Vars: map[string]interface{}{
			"bucket_name":            bucketName,
			"route53_zone_id":        "Z050385224FJUG7TIV71C",
			"route53_hosted_zone_id": "Z050385224FJUG7TIV71C",
			"s3_force_destroy":       s3ForceDestroy,
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
