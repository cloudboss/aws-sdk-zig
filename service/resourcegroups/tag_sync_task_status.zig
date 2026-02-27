pub const TagSyncTaskStatus = enum {
    active,
    @"error",

    pub const json_field_names = .{
        .active = "ACTIVE",
        .@"error" = "ERROR",
    };
};
