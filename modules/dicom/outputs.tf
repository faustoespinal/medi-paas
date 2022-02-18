output "namespace" {
  description = "Namespace output parameter from DICOM"
  value       = helm_release.orthanc.namespace
}

output "release_name" {
  description = "Namespace output parameter from DICOM"
  value       = "DICOM"
}

output "module_status" {
  description = "Status output variable based on the status of last deployed helm chart"
  value       = helm_release.orthanc.metadata
}
