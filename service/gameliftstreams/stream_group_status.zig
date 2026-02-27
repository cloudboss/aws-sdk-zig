pub const StreamGroupStatus = enum {
    activating,
    updating_locations,
    active,
    active_with_errors,
    @"error",
    deleting,
    expired,

    pub const json_field_names = .{
        .activating = "ACTIVATING",
        .updating_locations = "UPDATING_LOCATIONS",
        .active = "ACTIVE",
        .active_with_errors = "ACTIVE_WITH_ERRORS",
        .@"error" = "ERROR",
        .deleting = "DELETING",
        .expired = "EXPIRED",
    };
};
