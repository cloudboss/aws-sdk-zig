pub const StreamGroupLocationStatus = enum {
    activating,
    active,
    @"error",
    removing,

    pub const json_field_names = .{
        .activating = "ACTIVATING",
        .active = "ACTIVE",
        .@"error" = "ERROR",
        .removing = "REMOVING",
    };
};
