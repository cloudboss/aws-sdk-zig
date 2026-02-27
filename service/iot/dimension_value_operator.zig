pub const DimensionValueOperator = enum {
    in,
    not_in,

    pub const json_field_names = .{
        .in = "IN",
        .not_in = "NOT_IN",
    };
};
