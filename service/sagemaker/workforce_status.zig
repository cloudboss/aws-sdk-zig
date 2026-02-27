pub const WorkforceStatus = enum {
    initializing,
    updating,
    deleting,
    failed,
    active,

    pub const json_field_names = .{
        .initializing = "INITIALIZING",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .failed = "FAILED",
        .active = "ACTIVE",
    };
};
