pub const GatewayState = enum {
    creating,
    active,
    updating,
    @"error",
    deleting,
    deleted,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .updating = "UPDATING",
        .@"error" = "ERROR",
        .deleting = "DELETING",
        .deleted = "DELETED",
    };
};
