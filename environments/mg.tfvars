
partner_cuid         = ""
landing_zones_folder = "production"

root_mg_name = "RootGroup"
root_role_assignments = [
  # Sample Root MG Role Assignments
  # {
  #   # Microsoft Corporation (Owner)
  #   role_definition_name = "Owner"
  #   principal_id         = "00000000-0000-0000-0000-000000000000"
  # }
]

management_group_subscription_map = {
  "Platform" = {
    id = "00000000-0000-0000-0000-000000000000"
    roles = [
      # {
      #   role_definition_name = "Contributor"
      #   principal_id         = "00000000-0000-0000-0000-000000000000"
      # }
    ]
    child_mgs = {
      "Identity" = {
        id        = "00000000-0000-0000-0000-000000000000"
        roles     = []
        child_mgs = {}
      },
      "Management" = {
        id        = "00000000-0000-0000-0000-000000000000"
        roles     = []
        child_mgs = {}
      },
      "Connectivity" = {
        id        = "00000000-0000-0000-0000-000000000000"
        roles     = []
        child_mgs = {}
      },
    }
  },
  "LandingZones" = {
    id    = "00000000-0000-0000-0000-000000000000"
    roles = []
    child_mgs = {
      "Corp" = {
        id        = "00000000-0000-0000-0000-000000000000"
        roles     = []
        child_mgs = {}
      },
      "Online" = {
        id        = "00000000-0000-0000-0000-000000000000"
        roles     = []
        child_mgs = {}
      }
    }
  },
  "Decomissioned" = {
    id        = "00000000-0000-0000-0000-000000000000"
    roles     = []
    child_mgs = {}
  },
  "Sandbox" = {
    id        = "00000000-0000-0000-0000-000000000000"
    roles     = []
    child_mgs = {}
  },
  "Lockout" = {
    id        = "00000000-0000-0000-0000-000000000000"
    roles     = []
    child_mgs = {}
  }
}
