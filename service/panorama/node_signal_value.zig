pub const NodeSignalValue = enum {
    pause,
    @"resume",

    pub const json_field_names = .{
        .pause = "PAUSE",
        .@"resume" = "RESUME",
    };
};
