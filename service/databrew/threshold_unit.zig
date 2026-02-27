pub const ThresholdUnit = enum {
    count,
    percentage,

    pub const json_field_names = .{
        .count = "COUNT",
        .percentage = "PERCENTAGE",
    };
};
