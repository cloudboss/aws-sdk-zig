pub const BatchDeleteConfigurationTaskStatus = enum {
    initializing,
    validating,
    deleting,
    completed,
    failed,

    pub const json_field_names = .{
        .initializing = "INITIALIZING",
        .validating = "VALIDATING",
        .deleting = "DELETING",
        .completed = "COMPLETED",
        .failed = "FAILED",
    };
};
