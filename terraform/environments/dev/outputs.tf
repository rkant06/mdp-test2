output "quarantine_zone" {
  description = "Name of the data lake S3 bucket"
  value       = module.quarantine_zone.bucket_name
}