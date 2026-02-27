pub const VisualType = enum {
    line,
    bar,
    stack,

    pub const json_field_names = .{
        .line = "LINE",
        .bar = "BAR",
        .stack = "STACK",
    };
};
