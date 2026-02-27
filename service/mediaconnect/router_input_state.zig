pub const RouterInputState = enum {
    creating,
    standby,
    starting,
    active,
    stopping,
    deleting,
    updating,
    @"error",
    recovering,
    migrating,

    pub const json_field_names = .{
        .creating = "CREATING",
        .standby = "STANDBY",
        .starting = "STARTING",
        .active = "ACTIVE",
        .stopping = "STOPPING",
        .deleting = "DELETING",
        .updating = "UPDATING",
        .@"error" = "ERROR",
        .recovering = "RECOVERING",
        .migrating = "MIGRATING",
    };
};
