pub const ParallelDataStatus = enum {
    creating,
    updating,
    active,
    deleting,
    failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .updating = "UPDATING",
        .active = "ACTIVE",
        .deleting = "DELETING",
        .failed = "FAILED",
    };
};
