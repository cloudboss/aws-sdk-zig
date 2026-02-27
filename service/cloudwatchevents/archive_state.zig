pub const ArchiveState = enum {
    enabled,
    disabled,
    creating,
    updating,
    create_failed,
    update_failed,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
        .creating = "CREATING",
        .updating = "UPDATING",
        .create_failed = "CREATE_FAILED",
        .update_failed = "UPDATE_FAILED",
    };
};
