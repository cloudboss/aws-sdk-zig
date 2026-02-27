pub const TooltipTarget = enum {
    both,
    bar,
    line,

    pub const json_field_names = .{
        .both = "BOTH",
        .bar = "BAR",
        .line = "LINE",
    };
};
