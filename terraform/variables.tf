variable "project_id" {
  default     = "ahmed-playground-289507"
  description = "The project_id to deploy the example instance into.  (e.g. \"simple-sample-project-1234\")"
}

variable "zone" {
  default     = "europe-west1-b"
  description = "The region to deploy to"
}

variable "bootstrap_token" {
  description = "kubeadm bootstrap token"
  default     = ""
}

variable "kube_version" {
  default = "1.20.2"
}