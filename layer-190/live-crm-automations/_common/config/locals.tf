locals {
  tags = merge(
    {
      app = var.service
      env = var.environment
    },

    local.team != null ? merge(
      {
        "managed_by:team" = local.team
      },

      lookup(local.teams[local.team], "xa", null) != null ? {
        "managed_by:xa" = local.teams[local.team].xa
      } : {}
    ) : {}
  )

  teams = data.terraform_remote_state.users.outputs.teams
}
