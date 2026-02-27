pub const DurationUnit = enum {
    s,
    ms,

    pub const json_field_names = .{
        .s = "S",
        .ms = "MS",
    };
};
