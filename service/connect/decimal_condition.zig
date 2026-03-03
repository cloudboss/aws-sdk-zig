const DecimalComparisonType = @import("decimal_comparison_type.zig").DecimalComparisonType;

/// A decimal search condition for Search APIs.
pub const DecimalCondition = struct {
    /// The type of comparison to be made when evaluating the decimal condition.
    comparison_type: ?DecimalComparisonType = null,

    /// A name of the decimal property to be searched.
    field_name: ?[]const u8 = null,

    /// A maximum value of the decimal property.
    max_value: ?f64 = null,

    /// A minimum value of the decimal property.
    min_value: ?f64 = null,

    pub const json_field_names = .{
        .comparison_type = "ComparisonType",
        .field_name = "FieldName",
        .max_value = "MaxValue",
        .min_value = "MinValue",
    };
};
