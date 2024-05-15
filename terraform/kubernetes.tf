provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "docker-desktop"
}

resource "kubernetes_deployment" "backend-pp3" {
  metadata {
    name = "backend-pp3"
    labels = {
      App = "backend-pp3"
    }
  }

  spec {    
    selector {
      match_labels = {
        App = "backend-pp3"
      }
    }
    template {
      metadata {
        labels = {
          App = "backend-pp3"
        }
      }
      spec {
        container {
          image = "andresp612/api-pp3"
          name  = "api-container"

          port {
            container_port = 5000
          }

          resources {
            limits = {
              cpu    = "500m"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "bdd-pp3" {
  metadata {
    name = "bdd-pp3"
    labels = {
      App = "bdd-pp3"
    }
  }

  spec {
    selector {
      match_labels = {
        App = "bdd-pp3"
      }
    }
    template {
      metadata {
        labels = {
          App = "bdd-pp3"
        }
      }
      spec {
        container {
          image = "mongo:jammy"
          name  = "bdd-container"

          port {
            container_port = 27017
          }

          resources {
            limits = {
              cpu    = "500m"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "frontend-pp3" {
  metadata {
    name = "frontend-pp3"
    labels = {
      App = "frontend-pp3"
    }
  }

  spec {
    selector {
      match_labels = {
        App = "frontend-pp3"
      }
    }
    template {
      metadata {
        labels = {
          App = "frontend-pp3"
        }
      }
      spec {
        container {
          image = "nginx:latest"
          name  = "web-container"

          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu    = "500m"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "backend-pp3" {
  metadata {
    name = "backend-pp3"
  }
  spec {
    selector = {
      App = kubernetes_deployment.backend-pp3.spec.0.template.0.metadata[0].labels.App
    }
    port {
      node_port   = 30201
      port        = 5000
      target_port = 5000
    }

    type = "NodePort"
  }
}

resource "kubernetes_service" "bdd-pp3" {
  metadata {
    name = "bdd-pp3"
  }
  spec {
    selector = {
      App = kubernetes_deployment.bdd-pp3.spec.0.template.0.metadata[0].labels.App
    }
    port {
      node_port   = 30202
      port        = 27017
      target_port = 27017
    }

    type = "NodePort"
  }
}

resource "kubernetes_service" "frontend-pp3" {
  metadata {
    name = "frontend-pp3"
  }
  spec {
    selector = {
      App = kubernetes_deployment.frontend-pp3.spec.0.template.0.metadata[0].labels.App
    }
    port {
      node_port   = 30203
      port        = 80
      target_port = 80
    }

    type = "NodePort"
  }
}