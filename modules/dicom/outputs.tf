output "namespace" {
  description = "Namespace output parameter from DICOM"
  value       = helm_release.orthanc.namespace
}

output "release_name" {
  description = "Namespace output parameter from DICOM"
  value       = "DICOM"
}

