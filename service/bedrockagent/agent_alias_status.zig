pub const AgentAliasStatus = enum {
    creating,
    prepared,
    failed,
    updating,
    deleting,
    dissociated,

    pub const json_field_names = .{
        .creating = "CREATING",
        .prepared = "PREPARED",
        .failed = "FAILED",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .dissociated = "DISSOCIATED",
    };
};
