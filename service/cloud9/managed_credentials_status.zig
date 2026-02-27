pub const ManagedCredentialsStatus = enum {
    enabled_on_create,
    enabled_by_owner,
    disabled_by_default,
    disabled_by_owner,
    disabled_by_collaborator,
    pending_removal_by_collaborator,
    pending_start_removal_by_collaborator,
    pending_removal_by_owner,
    pending_start_removal_by_owner,
    failed_removal_by_collaborator,
    failed_removal_by_owner,

    pub const json_field_names = .{
        .enabled_on_create = "ENABLED_ON_CREATE",
        .enabled_by_owner = "ENABLED_BY_OWNER",
        .disabled_by_default = "DISABLED_BY_DEFAULT",
        .disabled_by_owner = "DISABLED_BY_OWNER",
        .disabled_by_collaborator = "DISABLED_BY_COLLABORATOR",
        .pending_removal_by_collaborator = "PENDING_REMOVAL_BY_COLLABORATOR",
        .pending_start_removal_by_collaborator = "PENDING_START_REMOVAL_BY_COLLABORATOR",
        .pending_removal_by_owner = "PENDING_REMOVAL_BY_OWNER",
        .pending_start_removal_by_owner = "PENDING_START_REMOVAL_BY_OWNER",
        .failed_removal_by_collaborator = "FAILED_REMOVAL_BY_COLLABORATOR",
        .failed_removal_by_owner = "FAILED_REMOVAL_BY_OWNER",
    };
};
