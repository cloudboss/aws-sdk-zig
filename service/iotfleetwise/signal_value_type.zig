pub const SignalValueType = enum {
    integer,
    floating_point,

    pub const json_field_names = .{
        .integer = "INTEGER",
        .floating_point = "FLOATING_POINT",
    };
};
