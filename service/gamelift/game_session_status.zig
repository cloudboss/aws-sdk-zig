pub const GameSessionStatus = enum {
    active,
    activating,
    terminated,
    terminating,
    @"error",

    pub const json_field_names = .{
        .active = "ACTIVE",
        .activating = "ACTIVATING",
        .terminated = "TERMINATED",
        .terminating = "TERMINATING",
        .@"error" = "ERROR",
    };
};
