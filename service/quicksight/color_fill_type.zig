pub const ColorFillType = enum {
    discrete,
    gradient,

    pub const json_field_names = .{
        .discrete = "DISCRETE",
        .gradient = "GRADIENT",
    };
};
