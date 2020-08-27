package test

import (
	"fmt"
	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"testing"
	"time"
)

func TestAppUnit(t *testing.T) {
	terraformOptions := &terraform.Options{
	TerraformDir: "../",
	}
	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)
	validate(t, terraformOptions)
}

func validate(t *testing.T, opts *terraform.Options) {
	url := terraform.Output(t, opts, "url")
	http_helper.HttpGetWithRetry(t,
	url, // URL to test
	200, // Expected status code
	"Welcome to the static site provisioned by Terraform !!!", // Expected body
	10, // Max retries
	3 * time.Second // Time between retries
	)
}

