module "cluster" {
  source = "./cluster"

  identifier = var.cluster_identifier
  username   = var.username
  password   = var.password
}

module "jenkins-1" {
  source = "./deployments"

  cluster_identifier     = var.cluster_identifier
  identifier             = "jenkins-1"
  docker_image           = "jenkins/jenkins"
  docker_image_tag       = "2.234"
  cpu                    = "300m"
  ram                    = "1Gi"
  jenkins_admin_password = var.jenkins_admin_password
  plugins_file           = "plugins_1.yaml"

  username               = var.username
  password               = var.username
  cluster_endpoint       = module.cluster.cluster_endpoint
  client_certificate     = module.cluster.client_certificate
  client_key             = module.cluster.client_key
  cluster_ca_certificate = module.cluster.cluster_ca_certificate
}

module "jenkins-2" {
  source = "./deployments"

  cluster_identifier     = var.cluster_identifier
  identifier             = "jenkins-2"
  docker_image           = "jenkins/jenkins"
  docker_image_tag       = "2.234"
  cpu                    = "300m"
  ram                    = "1Gi"
  jenkins_admin_password = var.jenkins_admin_password
  plugins_file           = "plugins_2.yaml"

  username               = var.username
  password               = var.username
  cluster_endpoint       = module.cluster.cluster_endpoint
  client_certificate     = module.cluster.client_certificate
  client_key             = module.cluster.client_key
  cluster_ca_certificate = module.cluster.cluster_ca_certificate
}

module "jenkins-3" {
  source = "./deployments"

  cluster_identifier     = var.cluster_identifier
  identifier             = "jenkins-3"
  docker_image           = "jenkins/jenkins"
  docker_image_tag       = "2.234"
  cpu                    = "300m"
  ram                    = "1Gi"
  jenkins_admin_password = var.jenkins_admin_password
  plugins_file           = "plugins_3.yaml"

  username               = var.username
  password               = var.username
  cluster_endpoint       = module.cluster.cluster_endpoint
  client_certificate     = module.cluster.client_certificate
  client_key             = module.cluster.client_key
  cluster_ca_certificate = module.cluster.cluster_ca_certificate
}

module "jenkins-4" {
  source = "./deployments"

  cluster_identifier     = var.cluster_identifier
  identifier             = "jenkins-4"
  docker_image           = "jenkins/jenkins"
  docker_image_tag       = "2.234"
  cpu                    = "300m"
  ram                    = "1Gi"
  jenkins_admin_password = var.jenkins_admin_password
  plugins_file           = "plugins_4.yaml"

  username               = var.username
  password               = var.username
  cluster_endpoint       = module.cluster.cluster_endpoint
  client_certificate     = module.cluster.client_certificate
  client_key             = module.cluster.client_key
  cluster_ca_certificate = module.cluster.cluster_ca_certificate
}

module "jenkins-5" {
  source = "./deployments"

  cluster_identifier     = var.cluster_identifier
  identifier             = "jenkins-5"
  docker_image           = "jenkins/jenkins"
  docker_image_tag       = "2.234"
  cpu                    = "300m"
  ram                    = "1Gi"
  jenkins_admin_password = var.jenkins_admin_password
  plugins_file           = "plugins_5.yaml"

  username               = var.username
  password               = var.username
  cluster_endpoint       = module.cluster.cluster_endpoint
  client_certificate     = module.cluster.client_certificate
  client_key             = module.cluster.client_key
  cluster_ca_certificate = module.cluster.cluster_ca_certificate
}
