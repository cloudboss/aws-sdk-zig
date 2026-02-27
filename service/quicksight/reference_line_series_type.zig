pub const ReferenceLineSeriesType = enum {
    bar,
    line,

    pub const json_field_names = .{
        .bar = "BAR",
        .line = "LINE",
    };
};
