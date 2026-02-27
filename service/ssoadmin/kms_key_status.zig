pub const KmsKeyStatus = enum {
    updating,
    enabled,
    update_failed,

    pub const json_field_names = .{
        .updating = "UPDATING",
        .enabled = "ENABLED",
        .update_failed = "UPDATE_FAILED",
    };
};
