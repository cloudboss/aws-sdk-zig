pub const GrowthType = enum {
    linear,
    exponential,

    pub const json_field_names = .{
        .linear = "LINEAR",
        .exponential = "EXPONENTIAL",
    };
};
