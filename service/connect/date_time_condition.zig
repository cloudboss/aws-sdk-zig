const DateTimeComparisonType = @import("date_time_comparison_type.zig").DateTimeComparisonType;

/// A datetime search condition for Search APIs.
pub const DateTimeCondition = struct {
    /// Datetime property comparison type.
    comparison_type: ?DateTimeComparisonType = null,

    /// A name of the datetime property to be searched
    field_name: ?[]const u8 = null,

    /// A maximum value of the property.
    max_value: ?[]const u8 = null,

    /// A minimum value of the property.
    min_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .comparison_type = "ComparisonType",
        .field_name = "FieldName",
        .max_value = "MaxValue",
        .min_value = "MinValue",
    };
};
