pub const HyperParameterScalingType = enum {
    auto,
    linear,
    logarithmic,
    reverse_logarithmic,

    pub const json_field_names = .{
        .auto = "AUTO",
        .linear = "LINEAR",
        .logarithmic = "LOGARITHMIC",
        .reverse_logarithmic = "REVERSE_LOGARITHMIC",
    };
};
