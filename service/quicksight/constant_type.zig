pub const ConstantType = enum {
    singular,
    range,
    collective,

    pub const json_field_names = .{
        .singular = "SINGULAR",
        .range = "RANGE",
        .collective = "COLLECTIVE",
    };
};
