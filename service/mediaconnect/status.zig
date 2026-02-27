pub const Status = enum {
    standby,
    active,
    updating,
    deleting,
    starting,
    stopping,
    @"error",

    pub const json_field_names = .{
        .standby = "STANDBY",
        .active = "ACTIVE",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .starting = "STARTING",
        .stopping = "STOPPING",
        .@"error" = "ERROR",
    };
};
