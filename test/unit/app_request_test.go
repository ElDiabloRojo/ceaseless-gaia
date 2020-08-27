package test

import (
	"testing"
	"time"

	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAppUnit(t *testing.T) {
	awsRegion := "us-east-1"
	PrimaryDomain := "module.foo.com"
	SubAltDomNames := []string{"*.foo.com", "bar.dev"}
	ValidMethod := "DNS"
	terraformOptions := &terraform.Options{
		TerraformDir: "../../modules/website",
		Vars: map[string]interface{}{
			"primary_domain":               PrimaryDomain,
			"subjective_alternative_names": SubAltDomNames,
			"validation_method":            ValidMethod,
			"tags":                         Tag,
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
