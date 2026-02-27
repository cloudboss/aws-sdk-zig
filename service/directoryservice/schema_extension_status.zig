pub const SchemaExtensionStatus = enum {
    initializing,
    creating_snapshot,
    updating_schema,
    replicating,
    cancel_in_progress,
    rollback_in_progress,
    cancelled,
    failed,
    completed,

    pub const json_field_names = .{
        .initializing = "INITIALIZING",
        .creating_snapshot = "CREATING_SNAPSHOT",
        .updating_schema = "UPDATING_SCHEMA",
        .replicating = "REPLICATING",
        .cancel_in_progress = "CANCEL_IN_PROGRESS",
        .rollback_in_progress = "ROLLBACK_IN_PROGRESS",
        .cancelled = "CANCELLED",
        .failed = "FAILED",
        .completed = "COMPLETED",
    };
};
