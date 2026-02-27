pub const LifeCycleState = enum {
    creating,
    available,
    updating,
    deleting,
    deleted,
    @"error",

    pub const json_field_names = .{
        .creating = "CREATING",
        .available = "AVAILABLE",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .@"error" = "ERROR",
    };
};
