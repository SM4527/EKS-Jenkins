<p align="center">

![Kubernetes](https://img.shields.io/badge/kubernetes-%23326ce5.svg?style=for-the-badge&logo=kubernetes&logoColor=white) ![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white) ![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white) ![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white) ![Nginx](https://img.shields.io/badge/nginx-%23009639.svg?style=for-the-badge&logo=nginx&logoColor=white) ![Jenkins](https://img.shields.io/badge/jenkins-%232C5263.svg?style=for-the-badge&logo=jenkins&logoColor=white) ![Shell Script](https://img.shields.io/badge/shell_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white)

![Stars](https://img.shields.io/github/stars/SM4527/EKS-Jenkins?style=for-the-badge) ![Forks](https://img.shields.io/github/forks/SM4527/EKS-Jenkins?style=for-the-badge) ![Issues](https://img.shields.io/github/issues/SM4527/EKS-Jenkins?style=for-the-badge) ![License](https://img.shields.io/github/license/SM4527/EKS-Jenkins?style=for-the-badge) [![Twitter URL](https://img.shields.io/twitter/url/https/twitter.com/Tamizhan99.svg?style=for-the-badge&label=Follow%20%40Tamizhan99)](https://twitter.com/Tamizhan99) 

</p>

# Project Title

Jenkins

## Description

Deploy Jenkins on an EKS cluster using Terraform and Helm.

## Getting Started

### Dependencies

* Docker
* AWS user with programmatic access and high privileges 
* Linux terminal
* Deploy an [EKS K8 Cluster](https://github.com/SM4527/EKS-Terraform) with Self managed Worker nodes on AWS using Terraform.
* Deploy a [NGINX Ingress](https://github.com/SM4527/EKS-Nginx-Ingress) on the above EKS cluster (Pod->service->Ingress->ELB+ACM->Route 53->Domain URL).

### Installing

* Clone the repository
* Set environment variable TF_VAR_AWS_PROFILE
* Review terraform variable values in variables.tf, locals.tf
* Override values in the Helm chart through the "chart_values.yaml" file
* Update GitHub oAuth ClientID & ClientSecret, GithubApp AppID, ID & Private Key attribue values.
* Update kubernetes.tf with the AWS S3 bucket name and key name from the output of the [EKS K8 Cluster](https://github.com/SM4527/EKS-Terraform/blob/master/outputs.tf)

### Executing program

* Configure AWS user with AWS CLI.

```
docker-compose run --rm aws configure --profile $TF_VAR_AWS_PROFILE

docker-compose run --rm aws sts get-caller-identity
```

* Specify appropriate Terraform workspace.

```
docker-compose run --rm terraform workspace show

docker-compose run --rm terraform workspace select default
```

* Run Terraform apply to create the EKS cluster, k8 worker nodes and related AWS resources.

```
./run-docker-compose.sh terraform init

./run-docker-compose.sh terraform validate

./run-docker-compose.sh terraform plan

./run-docker-compose.sh terraform apply
```

* Verify jenkins pod is running and the Ingress is set correctly.

```
./run-docker-compose.sh kubectl get all -A | grep -i jenkins

./run-docker-compose.sh kubectl get ingress -n cicd

./run-docker-compose.sh kubectl get cm -n cicd
```

* Login to Jenkins using the Domain Https URL, prefixed by "jenkins." and when prompted, enter jenkins admin username and password.

## Help

## Authors

[Sivanandam Manickavasagam](https://www.linkedin.com/in/sivanandammanickavasagam)

## Version History

* 0.1
    * Initial Release

## License

This project is licensed under the MIT License - see the LICENSE file for details

## Repo rosters

### Stargazers

[![Stargazers repo roster for @SM4527/EKS-Jenkins](https://reporoster.com/stars/dark/SM4527/EKS-Jenkins)](https://github.com/SM4527/EKS-Jenkins/stargazers)
