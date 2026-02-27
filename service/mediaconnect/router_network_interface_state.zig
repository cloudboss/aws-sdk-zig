pub const RouterNetworkInterfaceState = enum {
    creating,
    active,
    updating,
    deleting,
    @"error",
    recovering,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .@"error" = "ERROR",
        .recovering = "RECOVERING",
    };
};
