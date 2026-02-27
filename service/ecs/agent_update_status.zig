pub const AgentUpdateStatus = enum {
    pending,
    staging,
    staged,
    updating,
    updated,
    failed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .staging = "STAGING",
        .staged = "STAGED",
        .updating = "UPDATING",
        .updated = "UPDATED",
        .failed = "FAILED",
    };
};
