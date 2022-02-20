<p align="center">

![Kubernetes](https://img.shields.io/badge/kubernetes-%23326ce5.svg?style=for-the-badge&logo=kubernetes&logoColor=white) ![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white) ![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white) ![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white) ![Nginx](https://img.shields.io/badge/nginx-%23009639.svg?style=for-the-badge&logo=nginx&logoColor=white) ![Jenkins](https://img.shields.io/badge/jenkins-%232C5263.svg?style=for-the-badge&logo=jenkins&logoColor=white) ![Shell Script](https://img.shields.io/badge/shell_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white)

![Stars](https://img.shields.io/github/stars/SM4527/EKS-Jenkins?style=for-the-badge) ![Forks](https://img.shields.io/github/forks/SM4527/EKS-Jenkins?style=for-the-badge) ![Issues](https://img.shields.io/github/issues/SM4527/EKS-Jenkins?style=for-the-badge) ![License](https://img.shields.io/github/license/SM4527/EKS-Jenkins?style=for-the-badge)

</p>

# Project Title

EKS-Jenkins-CICD  [![Tweet](https://img.shields.io/twitter/url/http/shields.io.svg?style=social)](https://twitter.com/intent/tweet?text=EKS%20-%20Jenkins%20-%20CICD&url=https://github.com/SM4527/EKS-Jenkins)

## Description

Automate CICD by deploying Jenkins on an AWS EKS Kubernetes cluster using Terraform and Helm.Leverage Jenkins Configuration as Code (JCasC) to configure Jenkins.Authentication and Authorization are using the GitHub OAuth plugin and the Matrix-Auth plugin.Automate CICD by setting up GitHub App and periodically scanning the GitHub Repos for the presence of a Jenkinsfile using the GitHub Branch Source plugin. Finally, Configure Kubernetes Agent to create Pods on the EKS Cluster to execute the various Pipeline stages.

<p align="center">

![image](https://user-images.githubusercontent.com/78129381/153651039-71dcf7c4-d22b-49d9-995d-5622409bb7ed.png)

![image](https://user-images.githubusercontent.com/78129381/153651338-928b6a90-b37f-465f-8e91-1ba7ee4019fd.png)

</p>

## Getting Started

### Dependencies

* Docker
* AWS user with programmatic access and high privileges 
* Linux terminal
* Deploy an [EKS K8 Cluster](https://github.com/SM4527/EKS-Terraform) with Self managed Worker nodes on AWS using Terraform.
* Deploy a [NGINX Ingress](https://github.com/SM4527/EKS-Nginx-Ingress) on the above EKS cluster (Pod->service->Ingress->ELB+ACM->Route 53->Domain URL).
* GitHub OAuth Setup: Follow the steps outlined below.

 https://plugins.jenkins.io/github-oauth/

```
Visit https://github.com/settings/applications/new to create a GitHub application registration.

The values for application name, homepage URL, or application description don't matter. They can be customized however desired.

However, the authorization callback URL takes a specific value. It must be https://jenkins.example.com/securityRealm/finishLogin where jenkins.example.com is the location of the Jenkins server.

The important part of the callback URL is /securityRealm/finishLogin

Finish by clicking Register application.
```

* GitHub App Setup: Follow the steps outlined below.

https://docs.cloudbees.com/docs/cloudbees-ci/latest/traditional-admin-guide/github-app-auth#_adding_the_jenkins_credential

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

* Login to Jenkins using your Domain Https URL, prefixed by "jenkins." and enter your GitHub username and password to proceed with further steps below.

* Start a new item, select Github Organization, select "Github App" Credential, and your Github username or Organization as owner and apply. Check out the exact steps below for the Github-Branch-Source plugin.

https://docs.cloudbees.com/docs/cloudbees-ci/latest/cloud-admin-guide/github-branch-source-plugin

* Scan organization Now and GitHub will check the GitHub Repositories for the presence of a Jenkinsfile and if present, will run the various stages. 

* The Kubernetes Agent in our Pipeline will create Pods on the EKS cluster to execute the various stages.

* The Stages can be visualized using the Blueocean Jenkins plugin that we have installed in our project.

* Automate CICD by scheduling the subsequent GitHub Repository scans at desired intervals.

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
