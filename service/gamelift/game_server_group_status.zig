pub const GameServerGroupStatus = enum {
    new,
    activating,
    active,
    delete_scheduled,
    deleting,
    deleted,
    @"error",

    pub const json_field_names = .{
        .new = "NEW",
        .activating = "ACTIVATING",
        .active = "ACTIVE",
        .delete_scheduled = "DELETE_SCHEDULED",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .@"error" = "ERROR",
    };
};
