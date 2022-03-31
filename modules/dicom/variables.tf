variable "module_name" {
  type    = string
  default = "dicom"
}

variable "module_root" {
  type    = string
  default = "."
}

variable "namespace" {
  type    = string
  default = "md-dicom"
}

variable "values_ohif_file_path" {
  type = string
  default = "values.yaml"
}

variable "values_orthanc_file_path" {
  type = string
  default = "values.yaml"
}

variable "values_load_dicom_path" {
  type = string
  default = "values.yaml"
}

variable "create_namespace" {
  type    = bool
  default = true
}

variable "release_creator" {
  type    = string
  description = "The installer of this module"
}

