# article-hosting-infrastructure
Infrastructure as code for Article Hosting

## Environments

- `curie`: Kubernetes cluster for general article hosting. No automated deployments set up.

## Manual deploy

### Prerequisites

In AWS console:
1. create S3 bucket "article-hosting-infra-terraform-test" in us-east-1
2. create hosted zone "article-hosting.adm-dokuwiki.tk" in Route53
3. in https://dash.cloudflare.com/6eb5fdc729955badf9bf7bf391b44620/adm-dokuwiki.tk/dns add at least 2 NS records from Route53
4. create certificate for domain named "article-hosting.adm-dokuwiki.tk" and "*.article-hosting.adm-dokuwiki.tk" in ACM (wait until status "issued")

```
cd tf/envs/curie
sudo tfswitch 0.13.6
sudo terraform init --backend-config="key=curie/terraform.tfstate" -input=false

#create VPC
sudo terraform plan --var-file prod.us-east-1.tfvars -out  /tmp/curie.plan -target module.vpc
sudo terraform apply "/tmp/curie.plan"

#create other resources
sudo terraform plan --var-file prod.us-east-1.tfvars -out /tmp/curie.plan
sudo terraform apply "/tmp/curie.plan"

# during resources creation will emailed SES confirmation from AWS (it need to confirm) 
```

destroy all resources
```
sudo terraform destroy --var-file prod.us-east-1.tfvars --force
```