pub const ProtectionGroupAggregation = enum {
    sum,
    mean,
    max,

    pub const json_field_names = .{
        .sum = "SUM",
        .mean = "MEAN",
        .max = "MAX",
    };
};
