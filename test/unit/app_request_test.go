package test

import (
	"fmt"
	"testing"
	"time"

	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAppUnit(t *testing.T) {
	awsRegion := "us-east-1"
	bucketName := "req-test.phytology.co.uk"
	s3ForceDestroy := true
	indexFileSource := "../../src/index.html"
	errorFileSource := "../../src/error.html"
	terraformOptions := &terraform.Options{
		TerraformDir: "../../modules/website",
		Vars: map[string]interface{}{
			"bucket_name":            bucketName,
			"route53_zone_id":        "Z050385224FJUG7TIV71C",
			"route53_hosted_zone_id": "Z050385224FJUG7TIV71C",
			"s3_force_destroy":       s3ForceDestroy,
			"index_file_source":      indexFileSource,
			"error_file_source":      errorFileSource,
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
	output := terraform.Output(t, terraformOptions, "route53_app_fqdn")
	url := fmt.Sprintf("https://%s", output)

	expectedStatus := 200
	expectedBody := "Welcome to the static site provisioned by Terraform!!!"
	maxRetries := 10
	timeBetweenRetries := 3 * time.Second
	http_helper.HttpGetWithRetry(t, url, nil, expectedStatus, expectedBody, maxRetries, timeBetweenRetries)
}
