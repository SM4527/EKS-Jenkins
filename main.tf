
  resource "helm_release" "jenkins" {
  name       = "jenkins"
  repository = "https://charts.jenkins.io"
  chart      = "jenkins"
  version    = "3.11.3"
  namespace = "cicd"
  create_namespace = true
  timeout = 300

  values = [
    "${file("./chart_values.yaml")}"
  ]

  set {
    name  = "cluster.enabled"
    value = "true"
  }

  set {
    name  = "metrics.enabled"
    value = "true"
  }

  depends_on = [local_file.kubeconfig_EKS_Cluster]

}