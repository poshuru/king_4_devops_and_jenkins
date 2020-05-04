# 4 - DevOps and Jenkins
### Proposed solution for DEPLOYMENT and maintainance of 5 Jenkins instances is based on Infrastructure as Code approach and consist of following elements:
1. Kubernetes cluster created with help of terraform module "cluster".
2. Jenkins deployed with help of Helm chart (described in module "deployments").

### Proposed solution for managing Jenkins PLUGINS with ability to perform downgrades:

#### Current solution without role-based model:
1. Maintain a *list of versioned Jenkins plugins inside files plugins_*.yaml*
2. To *install/update/downgrade a plugin* you just need to modify plugins_*.yaml according to your needs and perform an update of Jenkins, i.e:
> terraform apply --target=module.jenkins-1 --auto-approve


Jenkins instance deployed with help of Helm chart will detect changes in plugins_1.yaml and adjust installed plugins according to the changes.


#### Complex solution with role-based model:
1. Install additional instance of an application that allows to create pipelines (i.e. Rundeck or another Jenkins instance that will act as controller server).
2. Create Git repository (config-repo) and move files plugins_*.yaml into it. Give developers write access to the repository.
3. Create a pipeline that will be triggered after commit to config-repo. The pipeline should be able to detect changes in plugins_*.yaml and execute following command:
> terraform apply --target=module.jenkins-1 --auto-approve

# Why I've choosen this solution and design
1. Managing Infrastrucutre as Code is the most reliable way to get an application working on any platform at any time. In addition to this Infrastructure as Code approach allows to perform easy rollbacks in case a change broke your infrastructure.
2. Jenkins team suggests only two ways to manage Jenkins plugins as code (https://github.com/jenkinsci/configuration-as-code-plugin/blob/master/README.md#installing-plugins):
- install plugins inside a custom Docker image;
- *manage plugins using Kubernetes helm chart (this one perfectly fits my soultion)*
3. Kubernetes provides self-healing mechanism so it means that maintenance of Jenkins instances is reduced to minimum.
4. Jenkins installed into Kubernetes cluster allows to run dynamic Jenkins agents inside Kubernetes pods. This can be very useful if your application is ready to be built inside containers.
5. Kubernetes support autoscaling so you can increase number of your Jenkins instances at any time.

# How to test the solution
NOTE: This particular solution was designed and tested with Google Kubernetes Engine but cluster module can be adjusted to any Kubernetes cluster implmentation.

### Prerequisites:
- GCP account
- Terraform 0.12 or newer

### Steps
1. Create GCP account, download account.json according to this manual https://cloud.google.com/iam/docs/creating-managing-service-account-keys#creating_service_account_keys and put it into root folder of this repository.
2. Initialize terraform modules:
> terraform init
3. Create cluster:
> terraform apply --target=module.cluster --auto-approve
4. Create first Jenkins instance:
> terraform apply --target=module.jenkins-1 --auto-approve

> NOTE: free tier account in GCP allows to create small VMs so proceed to following steps only if you are on paid plan.
5. Create the rest Jenkins instances:
> terraform apply --target=module.jenkins-2 --auto-approve

> terraform apply --target=module.jenkins-3 --auto-approve

> ...
