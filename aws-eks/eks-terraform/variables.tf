variable "AWS_ACCESS_KEY" {
  default = ""
}
variable "AWS_SECRET_KEY" {
  default = ""
}

variable "AWS_REGION" {
  default = "us-east-1"
}

variable "kubeconfig_file_path" {
  type = string
  default = "/home/ajit_web25/.kube/config"
}