pub const Mode = enum {
    @"resume",
    new,
    auto,

    pub const json_field_names = .{
        .@"resume" = "RESUME",
        .new = "NEW",
        .auto = "AUTO",
    };
};
