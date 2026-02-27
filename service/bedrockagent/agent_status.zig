pub const AgentStatus = enum {
    creating,
    preparing,
    prepared,
    not_prepared,
    deleting,
    failed,
    versioning,
    updating,

    pub const json_field_names = .{
        .creating = "CREATING",
        .preparing = "PREPARING",
        .prepared = "PREPARED",
        .not_prepared = "NOT_PREPARED",
        .deleting = "DELETING",
        .failed = "FAILED",
        .versioning = "VERSIONING",
        .updating = "UPDATING",
    };
};
