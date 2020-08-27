package test

import (
	"testing"
	"time"

	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAppUnit(t *testing.T) {
	terraformOptions := &terraform.Options{
		TerraformDir: ".",
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
