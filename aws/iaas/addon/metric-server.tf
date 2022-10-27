/*resource "helm_release" "metric-server" {
  name      = "metric-server"
  namespace = "kube-system"

  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metric-server"
  version    = "3.8.2"

  values     = [
    "${file("helm_values/metric.yaml")}"
  ]

  set {
    name  = "image.repository"
    value = "v2-zcr.cloudzcp.io/cloudzcp-public/metrics-server/metrics-server"
  }

  set {
    name  = "image.tag"
    value = "v0.6.1"
  }

  set {
    name  = "apiService.create"
    value = true
  }
}*/