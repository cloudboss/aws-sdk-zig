/// State of a logging configuration.
pub const LoggingConfigurationStatusCode = enum {
    /// Logging configuration is being created. Update/Deletion is disallowed until
    /// logging configuration is ACTIVE and workspace status is ACTIVE.
    creating,
    /// Logging configuration has been created/updated. Update/Deletion is
    /// disallowed until logging configuration is ACTIVE and workspace status is
    /// ACTIVE.
    active,
    /// Logging configuration is being updated. Update/Deletion is disallowed until
    /// logging configuration is ACTIVE and workspace status is ACTIVE.
    updating,
    /// Logging configuration is being deleting. Update/Deletion is disallowed until
    /// logging configuration is ACTIVE and workspace status is ACTIVE.
    deleting,
    /// Logging configuration creation failed.
    creation_failed,
    /// Logging configuration update failed.
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
