pub const NetworkDirection = enum {
    in,
    out,

    pub const json_field_names = .{
        .in = "IN",
        .out = "OUT",
    };
};
