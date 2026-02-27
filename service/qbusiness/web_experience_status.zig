pub const WebExperienceStatus = enum {
    creating,
    active,
    deleting,
    failed,
    pending_auth_config,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .deleting = "DELETING",
        .failed = "FAILED",
        .pending_auth_config = "PENDING_AUTH_CONFIG",
    };
};
