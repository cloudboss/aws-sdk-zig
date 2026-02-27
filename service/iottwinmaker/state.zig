pub const State = enum {
    creating,
    updating,
    deleting,
    active,
    @"error",

    pub const json_field_names = .{
        .creating = "CREATING",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .active = "ACTIVE",
        .@"error" = "ERROR",
    };
};
