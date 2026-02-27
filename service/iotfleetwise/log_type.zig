pub const LogType = enum {
    off,
    @"error",

    pub const json_field_names = .{
        .off = "OFF",
        .@"error" = "ERROR",
    };
};
