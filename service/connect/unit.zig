pub const Unit = enum {
    seconds,
    count,
    percent,

    pub const json_field_names = .{
        .seconds = "SECONDS",
        .count = "COUNT",
        .percent = "PERCENT",
    };
};
