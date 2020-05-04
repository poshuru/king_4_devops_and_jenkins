data "helm_repository" "stable" {
  name = "stable"
  url  = "https://kubernetes-charts.storage.googleapis.com"
}

resource "helm_release" "example" {
  name       = "${var.identifier}-release-1"
  repository = data.helm_repository.stable.metadata[0].name
  chart      = "stable/jenkins"
  version    = "1.0.0"

  values = [
    "${file("values.yaml")}",
    "${file(var.plugins_file)}"
  ]

  set {
    name = "master.resources.requests.cpu"
    value = var.cpu
  }

  set {
    name = "master.resources.limits.cpu"
    value = var.cpu
  }

  set {
    name = "master.resources.requests.memory"
    value = var.ram
  }

  set {
    name = "master.resources.limits.memory"
    value = var.ram
  }

  set {
    name  = "master.adminPassword"
    value = var.jenkins_admin_password
  }

  set {
    name  = "persistence.existingClaim"
    value = kubernetes_persistent_volume_claim.this.metadata.0.name
  }

  set {
    name  = "master.image"
    value = var.docker_image
  }

  set {
    name  = "master.imageTag"
    value = var.docker_image_tag
  }
}

resource "google_compute_disk" "this" {
  name  = "${var.identifier}-disk"
  type  = "pd-ssd"
  zone  = "us-central1-a"
}

resource "kubernetes_persistent_volume" "this" {
  metadata {
    name = "${var.identifier}-volume"
  }
  spec {
    capacity = {
      storage = "1Gi"
    }
    access_modes = ["ReadWriteMany"]
    persistent_volume_source {
      gce_persistent_disk {
        pd_name = "${var.identifier}-disk"
      }
    }
    storage_class_name = "standard"
  }

  depends_on = [
    google_compute_disk.this,
  ]
}

resource "kubernetes_persistent_volume_claim" "this" {
  metadata {
    name = "${var.identifier}-pvc"
  }
  spec {
    access_modes = ["ReadWriteMany"]
    resources {
      requests = {
        storage = "1Gi"
      }
    }
    volume_name = kubernetes_persistent_volume.this.metadata.0.name
    storage_class_name = "standard"
  }
}
