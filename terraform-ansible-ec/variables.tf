variable "AWS_ACCESS_KEY" {
  default = "AKIAQLWU2HXDUP5CNA26"
}
variable "AWS_SECRET_KEY" {
  default = "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"
}

variable "KEY_NAME" {
  default = "myelasticsearch"
}

variable "LOCAL_KEY_NAME" {
  default = "keys/elasticsearch.pem"
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}

variable "AWS_REGION" {
  default = "us-east-1"
}


variable "AMIS" {
    description = "AMIs by region"
    default = {
        us-east-1 = "ami-07df16d0682f1fa59" # ubuntu 16.04 LTS
    }
}

