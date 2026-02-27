pub const RouteState = enum {
    creating,
    active,
    deleting,
    failed,
    updating,
    inactive,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .deleting = "DELETING",
        .failed = "FAILED",
        .updating = "UPDATING",
        .inactive = "INACTIVE",
    };
};
