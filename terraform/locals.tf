locals {
  resource_lowercase_array  = [lower(var.environment), substr(lower(var.location), 0, 2), substr(lower(var.application), 0, 3), random_id.resource_group_name_suffix.hex, var.resource_group_name_suffix]
  resource_suffix_kebabcase = join("-", local.resource_lowercase_array)

  dev_center_environment_types = toset(["dev", "test", "prod"])
  users_index                  = toset([for i in range(var.number_of_users) : format("%s", i)])

  tags = merge(
    var.tags,
    tomap(
      {
        "Deployment"  = "terraform",
        "ProjectName" = "hands-on-lab-platform-engineering-for-ops",
        "Environment" = var.environment,
        "Location"    = var.location,
      }
    )
  )
}
