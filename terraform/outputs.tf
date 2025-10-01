output "efs_id" {
  description = "EFS filesystem ID"
  value       = module.efs.file_system_id
}

output "efs_sg_id" {
  description = "Security group attached to EFS mount targets"
  value       = module.efs.security_group_id
}

output "efs_access_points" {
  description = "Map of access point names to IDs"
  value       = module.efs.access_point_ids_by_name
}
