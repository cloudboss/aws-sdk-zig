pub const ScalingType = enum {
    auto,
    linear,
    logarithmic,
    reverse_logarithmic,

    pub const json_field_names = .{
        .auto = "Auto",
        .linear = "Linear",
        .logarithmic = "Logarithmic",
        .reverse_logarithmic = "ReverseLogarithmic",
    };
};
