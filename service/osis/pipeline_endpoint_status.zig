pub const PipelineEndpointStatus = enum {
    creating,
    active,
    create_failed,
    deleting,
    revoking,
    revoked,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .create_failed = "CREATE_FAILED",
        .deleting = "DELETING",
        .revoking = "REVOKING",
        .revoked = "REVOKED",
    };
};
