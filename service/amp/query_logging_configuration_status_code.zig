pub const QueryLoggingConfigurationStatusCode = enum {
    /// Query logging configuration is being created.
    creating,
    /// Query logging configuration is active.
    active,
    /// Query logging configuration is being updated.
    updating,
    /// Query logging configuration is being deleted.
    deleting,
    /// Query logging configuration creation failed.
    creation_failed,
    /// Query logging configuration update failed.
    update_failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .creation_failed = "CREATION_FAILED",
        .update_failed = "UPDATE_FAILED",
    };
};
