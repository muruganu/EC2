variable "key_file" {}

variable "user_data" {}

variable "instance_type" {
  type = string
  default = "t2.nano"
}

variable "sg_name" {}