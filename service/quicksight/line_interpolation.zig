pub const LineInterpolation = enum {
    linear,
    smooth,
    stepped,

    pub const json_field_names = .{
        .linear = "LINEAR",
        .smooth = "SMOOTH",
        .stepped = "STEPPED",
    };
};
