pub const ComparisonOperator = enum {
    greater_than_or_equal_to_threshold,
    greater_than_threshold,
    less_than_threshold,
    less_than_or_equal_to_threshold,

    pub const json_field_names = .{
        .greater_than_or_equal_to_threshold = "GreaterThanOrEqualToThreshold",
        .greater_than_threshold = "GreaterThanThreshold",
        .less_than_threshold = "LessThanThreshold",
        .less_than_or_equal_to_threshold = "LessThanOrEqualToThreshold",
    };
};
