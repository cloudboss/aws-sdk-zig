pub const ScalarAttributeType = enum {
    s,
    n,
    b,

    pub const json_field_names = .{
        .s = "S",
        .n = "N",
        .b = "B",
    };
};
