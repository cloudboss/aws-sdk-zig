pub const DateTimeType = enum {
    absolute,
    relative,

    pub const json_field_names = .{
        .absolute = "ABSOLUTE",
        .relative = "RELATIVE",
    };
};
